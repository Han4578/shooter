extends CharacterBody2D
class_name GroundItem

var speed := 500
var icon: Texture
var time := 0.0
@export var collectible: Collectible

@onready var movement_component := $MovementComponent
@onready var tracking_component := $TrackingComponent
@onready var sprite := $Sprite2D

static func create_item(collectible: Collectible) -> GroundItem:
	var ground_item := GroundItem.new()
	ground_item.collectible = collectible
	return ground_item
	
func _ready() -> void:
	sprite.texture = collectible.icon
	InventoryManager.inventory_signal.connect(_on_inventory_full)
	stop_moving()
	
func _process(delta: float) -> void:
	time += delta
	sprite.position.y += sin(time * PI)

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _on_inventory_full(type: InventoryManager, is_full: bool) -> void:
	if is_full and collectible is CollectibleItem and collectible.type == type: stop_moving()
	
func start_moving() -> void:
	movement_component.set_speed(speed)
	tracking_component.start_tracking = true
	
func stop_moving() -> void:
	movement_component.set_speed(0)
	tracking_component.start_tracking = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(&"Ally"):
		collectible.pick_up()
		queue_free()

func _on_velocity_changed(new_velocity: Vector2) -> void:
	velocity = new_velocity
