extends ItemSlot
class_name InventorySlot

func _ready() -> void:
	super()
	InventoryManager.inventory[type].append(self)
	
func _on_child_entered_tree(node: Node) -> void:
	if node is ItemContainer:
		if node is WeaponItemContainer: node.content.current_owner = Global.player
		occupied = true
		InventoryManager.inventory_count[node.type] -= 1
			
		if InventoryManager.inventory_count[node.type] == 0: 
			InventoryManager.inventory_signal.emit(node.type, true)

func _on_child_exiting_tree(node: Node) -> void:
	if node is ItemContainer:
		occupied = false
		InventoryManager.inventory_count[node.type] += 1
			
		if InventoryManager.inventory_count[node.type] == 1: 
			InventoryManager.inventory_signal.emit(node.type, false)
	
