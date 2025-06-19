extends ItemSlot
class_name UpgradeSlot

@export var index := 0
var current_container: WeaponItemContainer
var ignore_upgrade := false

func _ready() -> void:
	super()
	InventoryManager.open_weapon_details.connect(_on_open_weapon_details)
	InventoryManager.close_weapon_details.connect(close_weapon_details)
	
func _on_open_weapon_details(container: WeaponItemContainer) -> void:
	if current_container: close_weapon_details()
	current_container = container
	if current_container.attachments[index] == null: return
	ignore_upgrade = true
	add_child(current_container.attachments[index])
	ignore_upgrade = false
	
func close_weapon_details():
	if current_container == null or current_container.attachments[index] == null: return
	ignore_upgrade = true
	remove_child(current_container.attachments[index])
	ignore_upgrade = false
	current_container = null
	
func _on_child_entered_tree(node: Node): 
	if ignore_upgrade: return
	if node is UpgradeItemContainer:
		current_container.attachments[index] = node
		node.details.upgrade.apply_to_weapon(current_container.content)

func _on_child_exited_tree(node: Node): 
	if ignore_upgrade: return
	if node is UpgradeItemContainer:
		current_container.attachments[index] = null
		node.details.upgrade.remove_from_weapon(current_container.content)
