extends Control

var focused := false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		Global.open_item_details.emit(get_parent())

func _get_drag_data(at_position: Vector2) -> Variant:
	return get_parent()._get_drag_data(at_position)
