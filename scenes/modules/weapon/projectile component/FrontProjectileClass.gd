extends Projectile
class_name FrontProjectile

@export var despawn_time := 1.5
@export var movement_component: MovementComponent
@export var collision_component: CollisionBoxComponent
var attack_context: AttackContext
var velocity := Vector2.ZERO
var hit_count := 1

func _ready() -> void:
	await get_tree().create_timer(despawn_time, false).timeout
	queue_free()
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func load_details(pos: Vector2, rot: float, despawn: float, speed: int, atk_context: AttackContext) -> void:
	global_position = pos
	despawn_time = despawn
	movement_component.set_direction(Vector2.from_angle(rot))
	movement_component.set_speed(speed)
	collision_component.attack_context = atk_context
	$Sprite2D.global_rotation = rot
	
func _on_velocity_changed(new_velocity: Vector2) -> void:
	velocity = new_velocity
	
func _on_area_collided() -> void:
	hit_count -= 1
	if hit_count == 0: collision_component.can_collide = false
	queue_free()
