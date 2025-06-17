extends Node2D

const num_of_weapon_slots := 5
const inventory_weapon_slot_count := 16
const inventory_chip_slot_count := 24
const inventory_attachment_slot_count := 24
var active_weapon_index := 0
var weapons: Array[Weapon] = []
var is_passive: Array[bool] = []

var inventory :Array[Array] = [[], [], []]

var inventory_count: Array[int] = [
	num_of_weapon_slots + inventory_weapon_slot_count, 
	inventory_chip_slot_count, 
	inventory_attachment_slot_count
]

enum ItemTypes {WEAPON=0, ATTACHMENT=1, CHIP=2}

signal active_swapped(index: int)
signal inventory_signal(type: ItemTypes, is_full: bool)
signal open_weapon_details(item: Control)
signal close_weapon_details()
	
func _ready() -> void:
	weapons.resize(num_of_weapon_slots)
	is_passive.resize(num_of_weapon_slots)
	is_passive.fill(false)
	Global.pause.connect(_on_pause)
	
func process_input(event: InputEventMouseButton, attack_context: AttackContext) -> void:
	if (weapons[active_weapon_index] != null and not is_passive[active_weapon_index]): weapons[active_weapon_index].process_input(event, attack_context)
	
func swap_weapon(next: bool) -> void:
	active_weapon_index = (active_weapon_index + (1 if next else -1)) % num_of_weapon_slots
	active_swapped.emit(active_weapon_index)
	
func change_passive(index: int) -> void:
	is_passive[index] = not is_passive[index]
	
func _on_pause(is_paused: bool) -> void:
	if not is_paused:
		for i in num_of_weapon_slots:
			if weapons[i]:
				if is_passive[i]: weapons[i].start_passive()	
				else: weapons[i].stop_passive()	
	
func get_slot_count(type: ItemTypes) -> int:
	match type:
		ItemTypes.WEAPON: return inventory_weapon_slot_count
		ItemTypes.ATTACHMENT: return inventory_attachment_slot_count
		ItemTypes.CHIP: return inventory_chip_slot_count
		_: return 0
