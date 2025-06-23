extends Node2D
class_name BoidCalculator

var rd: RenderingDevice

var to_bin_shader: RID
var to_bin_pipeline: RID

var prefix_sum_shader: RID
var prefix_sum_pipeline: RID

var boid_reindex_shader: RID
var boid_reindex_pipeline: RID

var calculate_boids_shader: RID
var calculate_boids_pipeline: RID

var positions_uniform: RDUniform
var results_uniform: RDUniform
var bin_uniform: RDUniform
var temp_bin_uniform: RDUniform
var boids_uniform: RDUniform
var config_uniform: RDUniform
var boid_info_uniform: RDUniform

var bin_buffer: RID
var temp_bin_buffer: RID
var boid_info_buffer: RID

const TABLE_LENGTH := 4096
const TABLE_BYTE_SIZE := TABLE_LENGTH * 4
const bin_workgroups := ceili(TABLE_LENGTH / 32.0)
const PREFIX_LOOP_COUNT := ceili(log(TABLE_LENGTH) / log(2))
const BOID_RADIUS := 40


func _ready() -> void:
	rd = RenderingServer.create_local_rendering_device()
	
	to_bin_shader = _create_shader(&"res://compute shader/to_bin.glsl")
	prefix_sum_shader = _create_shader(&"res://compute shader/prefix_sum.glsl")
	boid_reindex_shader = _create_shader(&"res://compute shader/boid_reindex.glsl")
	calculate_boids_shader = _create_shader(&"res://compute shader/calculate_boids.glsl")
	
	to_bin_pipeline = rd.compute_pipeline_create(to_bin_shader)
	prefix_sum_pipeline = rd.compute_pipeline_create(prefix_sum_shader)
	boid_reindex_pipeline = rd.compute_pipeline_create(boid_reindex_shader)
	calculate_boids_pipeline = rd.compute_pipeline_create(calculate_boids_shader)
	
	# Create uniform set containing all uniforms
	positions_uniform = _create_uniform(0)
	results_uniform = _create_uniform(1)
	bin_uniform = _create_uniform(2)
	temp_bin_uniform = _create_uniform(3)
	boids_uniform = _create_uniform(4)
	config_uniform = _create_uniform(5, RenderingDevice.UNIFORM_TYPE_UNIFORM_BUFFER)
	boid_info_uniform = _create_uniform(6, RenderingDevice.UNIFORM_TYPE_UNIFORM_BUFFER)
		
	bin_buffer = rd.storage_buffer_create(TABLE_BYTE_SIZE)	
	temp_bin_buffer = rd.storage_buffer_create(TABLE_BYTE_SIZE)
	boid_info_buffer = rd.uniform_buffer_create(16, PackedInt32Array([BOID_RADIUS * 2, 0, 0, 0]).to_byte_array())
	
	bin_uniform.add_id(bin_buffer)
	temp_bin_uniform.add_id(temp_bin_buffer)
	boid_info_uniform.add_id(boid_info_buffer)
	


func _physics_process(_delta: float) -> void:
	if Engine.get_physics_frames() % 5 == 0: _calculate_boids()
	
	
func _calculate_boids() -> void:
	if Pooling.entities[Pooling.BOID_ENTITY].size() == 0: return
	# Create buffers
	var positions := PackedVector2Array()
	
	for boid: BoidComponent in Pooling.entities[Pooling.EntityTypes.BOID].keys():
		positions.append(boid.global_position)
	var positions_byte := positions.to_byte_array()
	
	var positions_buffer := rd.storage_buffer_create(positions_byte.size(), positions_byte)
	var results_buffer := rd.storage_buffer_create(positions_byte.size())
	var boids_buffer := rd.storage_buffer_create(positions.size() * 4)
	
	rd.buffer_clear(bin_buffer, 0, TABLE_BYTE_SIZE)
	rd.buffer_clear(temp_bin_buffer, 0, TABLE_BYTE_SIZE)
	
	# Put storage buffers in uniforms
	positions_uniform.add_id(positions_buffer)
	results_uniform.add_id(results_buffer)
	boids_uniform.add_id(boids_buffer)
	
	var to_bin_uniform_set := rd.uniform_set_create([positions_uniform, bin_uniform, boid_info_uniform], to_bin_shader, 0)
	
	var boid_workgroups := ceili(positions.size() / 32.0)
	var prefix_offset := 1
	
	var compute_list := rd.compute_list_begin()
	_dispatch_pipeline(to_bin_pipeline, boid_workgroups, compute_list, to_bin_uniform_set)
	rd.compute_list_add_barrier(compute_list)
	
	for i in PREFIX_LOOP_COUNT:
		var bytes := PackedByteArray()
		bytes.resize(16)
		bytes.encode_u32(0, prefix_offset)
		var config_buffer := rd.uniform_buffer_create(16, bytes)
		config_uniform.add_id(config_buffer)
		var prefix_sum_bin_uniform_set := rd.uniform_set_create([bin_uniform, temp_bin_uniform, config_uniform], prefix_sum_shader, 0)
		
		_dispatch_pipeline(prefix_sum_pipeline, bin_workgroups, compute_list, prefix_sum_bin_uniform_set)
		rd.compute_list_add_barrier(compute_list)
		
		# Swap bin buffer and temp bin buffer 
		rd.free_rid(prefix_sum_bin_uniform_set)
		bin_uniform.clear_ids()
		temp_bin_uniform.clear_ids()
		config_uniform.clear_ids()
		
		bin_uniform.add_id(temp_bin_buffer)
		temp_bin_uniform.add_id(bin_buffer)
		
		rd.free_rid(config_buffer)
		var temp := bin_buffer
		bin_buffer = temp_bin_buffer
		temp_bin_buffer = temp
		prefix_offset <<= 1
	
	var boid_reindex_uniform_set := rd.uniform_set_create([positions_uniform, bin_uniform, boids_uniform, boid_info_uniform], boid_reindex_shader, 0)
	var calculate_boids_uniform_set := rd.uniform_set_create([positions_uniform, bin_uniform, boids_uniform, results_uniform, boid_info_uniform], calculate_boids_shader, 0)
	
	_dispatch_pipeline(boid_reindex_pipeline, boid_workgroups, compute_list, boid_reindex_uniform_set)
	rd.compute_list_add_barrier(compute_list)
	_dispatch_pipeline(calculate_boids_pipeline, boid_workgroups, compute_list, calculate_boids_uniform_set)
	rd.compute_list_end()
	
	rd.submit()
	rd.sync()

	var results := rd.buffer_get_data(results_buffer)
	var i := 0
	
	
	for boid: BoidComponent in Pooling.entities[Pooling.EntityTypes.BOID].keys():
		boid.set_final_velocity(Vector2(results.decode_float(i * 8), results.decode_float(i * 8 + 4)))
		i += 1

	positions_uniform.clear_ids()
	results_uniform.clear_ids()
	boids_uniform.clear_ids()
	
	rd.free_rid(to_bin_uniform_set)
	rd.free_rid(boid_reindex_uniform_set)
	rd.free_rid(calculate_boids_uniform_set)
	
	rd.free_rid(positions_buffer)
	rd.free_rid(results_buffer)
	rd.free_rid(boids_buffer)

# Create compute list, bind pipeline and uniform set, then set workgroups 
func _dispatch_pipeline(pipeline: RID, workgroups: int, compute_list: int, uniform_set: RID):
	rd.compute_list_bind_compute_pipeline(compute_list, pipeline)
	rd.compute_list_bind_uniform_set(compute_list, uniform_set, 0)
	rd.compute_list_dispatch(compute_list, workgroups, 1, 1)	
	
func _create_shader(file_path: StringName):
	var file : RDShaderFile = load(file_path)
	var spriv := file.get_spirv()
	return rd.shader_create_from_spirv(spriv)
	
func _create_uniform(binding: int, uniform_type: RenderingDevice.UniformType = RenderingDevice.UNIFORM_TYPE_STORAGE_BUFFER) -> RDUniform:
	var uniform := RDUniform.new()
	uniform.uniform_type = uniform_type
	uniform.binding = binding
	return uniform
	
func _exit_tree() -> void:
	rd.free_rid(to_bin_pipeline)
	rd.free_rid(prefix_sum_pipeline)
	rd.free_rid(boid_reindex_pipeline)
	rd.free_rid(calculate_boids_pipeline)
	
	rd.free_rid(to_bin_shader)
	rd.free_rid(prefix_sum_shader)
	rd.free_rid(boid_reindex_shader)
	rd.free_rid(calculate_boids_shader)
	
	rd.free_rid(bin_buffer)
	rd.free_rid(temp_bin_buffer)
	rd.free_rid(boid_info_buffer)
	rd.free()
	
