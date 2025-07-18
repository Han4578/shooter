extends Node2D
class_name Weapon

var current_owner: Node2D
var can_fire := true
var holding := 0
var is_passive := false
var latest_attack_context: AttackContext

@export var general_stat_upgrades := StatUpgrades.new()

@export_subgroup(&"Primary Attack", &"primary_")
@export var primary_trigger : TriggerComponent
@export var primary_stat_upgrades := StatUpgrades.new()

@export_subgroup(&"Secondary Attack", &"secondary_")
@export var secondary_trigger : TriggerComponent
@export var secondary_stat_upgrades := StatUpgrades.new()

@export_subgroup(&"Passive Attack", &"passive_")
@export var passive_trigger : TriggerComponent
@export var passive_stat_upgrades := StatUpgrades.new()

signal cd_start(time: float)
signal direction_changed(new_direction: Vector2)
signal passive_started()
signal passive_ended()
	
func _ready() -> void:
	Global.pause.connect(_on_pause)
			
func _on_pause(_is_paused: bool):
	if _is_paused:
		primary_trigger.is_holding = false
		secondary_trigger.is_holding = false
		is_passive = false

func process_input(event: InputEventMouseButton, attack_context: AttackContext):
	attack_context.stat_upgrades.add_to_stats(general_stat_upgrades)
	attack_context.weapon = self
	latest_attack_context = attack_context
	if (event.is_action("primary fire")):
		attack_context.stat_upgrades.add_to_stats(primary_stat_upgrades)
		primary_trigger.process_event(event.pressed, can_fire, holding > 0, attack_context)
		holding += 1 if (event.pressed) else -1
	elif (event.is_action("secondary fire")):
		attack_context.stat_upgrades.add_to_stats(secondary_stat_upgrades)
		secondary_trigger.process_event(event.pressed, can_fire, holding > 0, attack_context)
		holding += 1 if (event.pressed) else -1

func _on_cd_start(t: float) -> void:
	cd_start.emit(t)
	can_fire = false

func _on_cd_end(trigger: TriggerComponent) -> void:
	can_fire = true
	if trigger.is_holding: trigger.process_event(true, true, holding > 1, latest_attack_context)
	elif is_passive: start_passive()
	
func _on_passive_end() -> void:
	can_fire = true
	if is_passive: passive_fire()
	
func _on_direction_changed(direction: Vector2):
	direction_changed.emit(direction)
		
func start_passive() -> void:
	is_passive = true
	passive_started.emit()
	if can_fire: passive_fire()
	
func stop_passive() -> void:
	is_passive = false
	passive_ended.emit()
	
func passive_fire() -> void:
	can_fire = false
	var attack_context :AttackContext= current_owner.create_attack_context()
	attack_context.weapon = self
	attack_context.stat_upgrades.add_to_stats(general_stat_upgrades)
	attack_context.stat_upgrades.add_to_stats(passive_stat_upgrades)
	passive_trigger.pull_trigger(attack_context)
	
