extends GPUParticles2D
class_name ParticleGenerator

static var damage_number_scene := preload("./DamageNumber.tscn")
static var throwable_scene := preload("./Throwable.tscn")

static func display_damage(dmg: float, pos: Vector2):
	var particle : ParticleGenerator = damage_number_scene.instantiate()
	particle.global_position = pos
	particle.get_node("SubViewport/Label").text = str(round(dmg))
	Global.map.add_child(particle)
	
static func display_throwable(from: Vector2, to: Vector2, txt: Texture):
	var particle : ParticleGenerator = throwable_scene.instantiate()
	particle.texture = txt
	particle.global_position = from
	var time := particle.lifetime
	var dx = (to.x - from.x) / time
	var dy = (to.y - from.y - 0.5 * particle.process_material.get_shader_parameter("gravity")[1] * time * time) / time
	var vec := Vector2(dx, dy)
	particle.process_material.set_shader_parameter("initial_velocity", vec)
	particle.process_material.set_shader_parameter("initial_position", from)
	Global.map.add_child(particle)
	
func _ready() -> void:
	restart()
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
