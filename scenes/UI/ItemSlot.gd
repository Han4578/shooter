extends Control
class_name ItemSlot

@export var type : InventoryManager.ItemTypes
var occupied := false

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is ItemContainer and data.type == type

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if (occupied): get_child(-1).reparent(data.get_parent(), false)
	data.reparent(self, false)
