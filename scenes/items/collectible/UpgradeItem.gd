extends CollectibleItem
class_name UpgradeItem

@export var upgrade: Upgrade

func _init() -> void:
	type = InventoryManager.ItemTypes.ATTACHMENT

func pick_up() -> void:
	var container: UpgradeItemContainer = container_scene.instantiate()
	container.upgrade = upgrade
	container.icon = icon
	container.type = type
	add_to_inventory(container)
