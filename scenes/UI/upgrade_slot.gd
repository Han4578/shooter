extends InventorySlot
class_name UpgradeSlot

signal upgrade_applied(upgrade: ItemContainer)
signal upgrade_removed(upgrade: ItemContainer)

func _on_child_entered_tree(node: Node): 
	if node is ItemContainer:
		upgrade_applied.emit(node)

func _on_child_exited_tree(node: Node): 
	if node is ItemContainer:
		upgrade_removed.emit(node)
