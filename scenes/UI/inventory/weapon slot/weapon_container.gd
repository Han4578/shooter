extends HBoxContainer

var weapon_slot_scene := preload("./weapon_slot.tscn")
var current_active_slot := InventoryManager.active_weapon_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.active_swapped.connect(_on_active_swapped)
	for i in range(InventoryManager.num_of_weapon_slots):
		var slot: WeaponSlot = weapon_slot_scene.instantiate()
		slot.index = i
		slot.type = InventoryManager.ItemTypes.WEAPON
		add_child(slot)
	get_child(current_active_slot).selected = true

func _on_active_swapped(new_index: int):
	get_child(current_active_slot).selected = false
	get_child(new_index).selected = true
	current_active_slot = new_index
