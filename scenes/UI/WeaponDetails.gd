extends NinePatchRect

#var display_item : Item = null
#@onready var weapon_background = $WeaponBg
#
#func _ready() -> void:
	#Global.open_item_details.connect(_on_open_item_details)
	#
#func _on_open_item_details(item: Item):
	#display_item = item
	#if item.type == Global.ItemTypes.WEAPON:
		#weapon_background.texture = item.get_node("Sprite").texture
#
#func _on_slot_upgrade_applied(upgrade: Item) -> void:
	#if display_item.type == Global.ItemTypes.WEAPON: display_item.upgrade_applied.emit(upgrade)
#
#func _on_slot_upgrade_removed(upgrade: Item) -> void:
	#if display_item.type == Global.ItemTypes.WEAPON: display_item.upgrade_removed.emit(upgrade)
