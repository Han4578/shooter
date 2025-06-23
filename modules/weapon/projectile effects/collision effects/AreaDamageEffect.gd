extends CollisionEffect
class_name AreaDamageEffect

@export var explosion_level := 1
@export var parameter: ScalingParameter
var area_shape := CircleShape2D.new()

func apply(body: BodyComponent, attack_context: AttackContext) -> void:
	area_shape.radius =  40 + 50 * explosion_level * (1 + attack_context.stat_upgrades.radius_bonus)

	for enemy in HashGrid.get_all_overlapping(
		area_shape,
		Transform2D(0, attack_context.collision_position)
	):
		enemy.take_damage(attack_context.get_final_damage(parameter), attack_context)
		attack_context.hit(enemy)
