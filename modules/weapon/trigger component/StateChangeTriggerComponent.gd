extends TriggerComponent
class_name StateChangeTriggerComponent

@export var change_on_click := false

func process_event(clicked: bool, can_fire: bool, other_input_holding: bool, attack_context: AttackContext):
	if (check_conditions(can_fire, other_input_holding) and (clicked or not change_on_click)): 
		pull_trigger(attack_context)
