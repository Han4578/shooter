extends CollectibleItem
class_name WeaponItem

@export var name: StringName

@export var primary_skill: SkillDescription
@export var secondary_skill: SkillDescription
@export var passive_skill: SkillDescription

@export var weapon_scene: PackedScene

func _init() -> void:
	type = InventoryManager.ItemTypes.WEAPON

func pick_up() -> void:
	var container: WeaponItemContainer = container_scene.instantiate()
	container.content = weapon_scene.instantiate()
	container.icon = icon
	add_to_inventory(container)
	
