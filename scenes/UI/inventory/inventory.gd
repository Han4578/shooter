extends GridContainer

@export var type : InventoryManager.ItemTypes
var current_filled := 0

const inventory_slot := preload("./inventory_slot.tscn")

func _ready() -> void:
	for i in InventoryManager.get_slot_count(type):
		var slot : InventorySlot = inventory_slot.instantiate()
		slot.type = type
		add_child(slot)
