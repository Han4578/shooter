extends Resource
class_name ScalingParameter

enum Parameters {ATTACK, DEFENCE, HEALTH, FLAT, NONE}
@export var parameter: Parameters
@export var scaling := 1.0
@export var flat_amount := 0

func get_amount(attack_context: AttackContext) -> float:
	var amount : float = flat_amount
	match parameter:
		Parameters.ATTACK: amount += attack_context.attack * scaling
		Parameters.DEFENCE: amount += attack_context.defence * scaling
		Parameters.HEALTH: amount += attack_context.health * scaling
		Parameters.FLAT: pass
		Parameters.NONE: return 0
	return amount
