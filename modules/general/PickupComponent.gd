extends Area2D
class_name PickupComponent

@export var radius := 100

var latest_direction := Vector2.ZERO

func _ready() -> void:
	InventoryManager.inventory_signal.connect(_on_inventory_free)
	$CollisionShape2D.shape.radius = radius
	
func _on_inventory_free(type: InventoryManager.ItemTypes, is_full: bool) -> void:
	if is_full: return
	
	for ground_item: GroundItem in get_overlapping_bodies():
		if ground_item.collectible is CollectibleItem and ground_item.collectible.type == type: ground_item.start_moving()

func _on_direction_changed(new_direction: Vector2) -> void:
	if new_direction != Vector2.ZERO: latest_direction = new_direction 

func _on_body_entered(body: Node2D) -> void:
	if body is GroundItem: 
		if body.collectible is CollectibleItem and InventoryManager.inventory_count[body.collectible.type] == 0: return
		body.start_moving()
