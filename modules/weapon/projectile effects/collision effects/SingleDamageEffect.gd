extends CollisionEffect
class_name SingleDamageEffect

@export var parameter: ScalingParameter

func apply(body: BodyComponent, attack_context: AttackContext) -> void:
	body.take_damage(attack_context.get_final_damage(parameter), attack_context)
	attack_context.hit(body)
