extends TriggerComponent
class_name SingleTriggerComponent

@export var fire_rate := 0.0
@export_subgroup("Allow Upgrades")
@export var fire_rate_bonus := true

func process_event(clicked: bool, can_fire: bool, other_input_holding: bool, attack_context: AttackContext):
	is_holding = clicked
	if check_conditions(can_fire, other_input_holding) and clicked:
		pull_trigger(attack_context) 
		
func pull_trigger(attack_context: AttackContext) -> void:
		attack_context.stat_upgrades.attributes[SingleTriggerComponent] = true
		trigger.emit(attack_context)
		cd_start.emit(fire_rate)
