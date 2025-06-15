extends BarrelComponent
class_name AreaBarrelComponent

@export var interval := 2.0
@export var spread := 1.0
@export var radius := 60
@export_group("Aerial Particle")
@export var launch_particle := false
@export var particle_texture : Texture

signal trigger_particle(from: Vector2, to: Vector2)
signal trigger

func _on_trigger(from: Vector2, to: Vector2, attributes: Dictionary) -> void: 
	for i  in projectile_count:
			
		if launch_particle: ParticleGenerator.display_throwable(from, to, particle_texture)
		await get_tree().create_timer(interval).timeout
	
