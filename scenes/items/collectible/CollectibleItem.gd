extends Collectible
class_name CollectibleItem

@export var container_scene: PackedScene
@export var rarity: Rarity
var type: InventoryManager.ItemTypes

func add_to_inventory(container: ItemContainer) -> void:
	for slot: InventorySlot in InventoryManager.inventory[type]:
		if slot.occupied: continue
		slot.add_child(container)
		break
