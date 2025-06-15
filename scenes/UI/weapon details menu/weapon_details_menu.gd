extends VBoxContainer

func _ready() -> void:
	InventoryManager.open_weapon_details.connect(_on_open_weapon_details)
	InventoryManager.close_weapon_details.connect(_on_close_weapon_details)
	visible = false
	
func _on_open_weapon_details(container: WeaponItemContainer) -> void:
	$WeaponBg.texture = container.icon
	$WeaponBg/Label.text = container.details.name
	visible = true
	
func _on_close_weapon_details() -> void:
	$WeaponBg.texture = null
	$WeaponBg/Label.text = ""
	visible = false
	
	
