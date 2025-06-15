extends ProjectileComponent
class_name FrontProjectileComponent

@export var projectile : PackedScene
@export var movement_speed := 1000
@export var despawn_time := 1.5
var weapon : Node2D


func _on_trigger(target: TargetComponent, offset: float, attack_context: AttackContext):
	var projectile_instance : FrontProjectile = projectile.instantiate()
	projectile_instance.load_details(target.get_target_from_position(), target.get_target_to_direction() + offset, despawn_time, movement_speed, attack_context)
	
	Global.map.add_child(projectile_instance)
