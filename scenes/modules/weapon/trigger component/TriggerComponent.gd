extends Node2D
class_name TriggerComponent

@export var ignore_cd := false
@export var ignore_other_input := false
var is_holding := false
var current_owner: BodyComponent

signal trigger(attack_context: AttackContext)
signal cd_start(t: float)

func check_conditions(can_fire: bool, other_input_holding: bool):
	return ((can_fire or ignore_cd) and (not other_input_holding or ignore_other_input))
	
func process_event(_clicked: bool, _can_fire: bool, _other_input_holding: bool, _attack_context: AttackContext): pass

func pull_trigger(attack_context: AttackContext) -> void:
	trigger.emit(attack_context)
		
	
