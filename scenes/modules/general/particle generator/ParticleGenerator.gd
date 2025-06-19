extends GPUParticles2D
class_name ParticleGenerator

static var throwable_scene := preload("./Throwable.tscn")
static var particle_layer: Node2D


static func display_throwable(from: Vector2, to: Vector2, txt: Texture):
	var particle : ParticleGenerator = Pooling.get_entity(throwable_scene)
	particle.texture = txt
	particle.global_position = from
	var time := particle.lifetime
	var dx = (to.x - from.x) / time
	var dy = (to.y - from.y - 0.5 * particle.process_material.get_shader_parameter("gravity")[1] * time * time) / time
	var vec := Vector2(dx, dy)
	particle.process_material.set_shader_parameter("initial_velocity", vec)
	particle.process_material.set_shader_parameter("initial_position", from)
	particle_layer.add_child(particle)
	
	
func _enter_tree() -> void:
	restart()
	await finished
	get_parent().remove_child(self)
	Pooling.return_entity(self)
	
