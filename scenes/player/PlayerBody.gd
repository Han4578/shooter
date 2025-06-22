extends CharacterBody2D

var stat_upgrades := StatUpgrades.new()
@export var entity_type: Pooling.EntityTypes
@export var stats_component: StatsComponent

signal direction_changed(new_direction: Vector2)

func _ready() -> void:
	Global.player = self
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func process_input(event: InputEvent) -> void:
	if (event is InputEventMouse):
		if (event.is_action_pressed("swap_next_weapon") or event.is_action_pressed("swap_previous_weapon")):
			InventoryManager.swap_weapon(event.is_action("swap_next_weapon"))
		elif event is InputEventMouseButton: 
			InventoryManager.process_input(event, create_attack_context())
	elif event is InputEventKey: 
		direction_changed.emit(Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down"))
		
func _on_death():
	visible = false
	

	
func _enter_tree() -> void:
	Pooling.entities[entity_type][self] = null
	reset_state()

func reset_state() -> void:
	for node: Node2D in get_children(true):
		if node.has_method(&"reset_state"): node.reset_state()
	
func _on_velocity_changed(new_velocity: Vector2):
	velocity = new_velocity

func create_attack_context() -> AttackContext:
	var attack_context := AttackContext.new()
	attack_context.stat_upgrades.add_to_stats(stat_upgrades)
	attack_context.owner = self
	attack_context.owner_position = global_position
	stats_component.add_stats(attack_context)
	return attack_context

func _on_attack_context_requested(node: CollisionBoxComponent) -> void:
	node.attack_context = create_attack_context()
