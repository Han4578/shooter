extends BodyComponent

signal direction_changed(new_direction: Vector2)

func _ready() -> void:
	Global.player = self

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
