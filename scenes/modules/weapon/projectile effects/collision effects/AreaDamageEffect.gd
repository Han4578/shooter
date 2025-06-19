extends CollisionEffect
class_name AreaDamageEffect

@export var explosion_level := 1
@export var parameter: ScalingParameter
var explosion_circle: PhysicsShapeQueryParameters2D

func _init() -> void:
	explosion_circle = PhysicsShapeQueryParameters2D.new()
	explosion_circle.collide_with_areas = true
	explosion_circle.collide_with_bodies = false
	explosion_circle.shape = CircleShape2D.new()

func apply(hitbox: HitBoxComponent, attack_context: AttackContext) -> void:
	explosion_circle.collision_mask = 2
	explosion_circle.shape.radius =  40 + 50 * explosion_level * (1 + attack_context.stat_upgrades.radius_bonus)
	explosion_circle.transform.origin = hitbox.global_position

	for node in hitbox.get_world_2d().direct_space_state.intersect_shape(explosion_circle):
		node[&"collider"].take_damage(attack_context.get_final_damage(parameter), attack_context)
		attack_context.hit(node[&"collider"])
