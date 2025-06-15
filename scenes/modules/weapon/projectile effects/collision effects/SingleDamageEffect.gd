extends CollisionEffect
class_name SingleDamageEffect

@export var parameter: ScalingParameter

func apply(hitbox: HitBoxComponent, attack_context: AttackContext) -> void:
	hitbox.take_damage(attack_context.get_final_damage(parameter), attack_context)
