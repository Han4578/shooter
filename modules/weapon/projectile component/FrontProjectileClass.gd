extends Projectile
class_name FrontProjectile

@export var despawn_time := 1.5
@export var movement_component: MovementComponent
@export var collision_box_component: CollisionBoxComponent
@export var timer: Timer
var velocity := Vector2.ZERO
var initial_hit_count := 1
	
func _enter_tree() -> void:
	timer.wait_time = despawn_time
	timer.call_deferred(&"start")

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func load_details(pos: Vector2, rot: float, despawn: float, speed: int, atk_context: AttackContext) -> void:
	reset_state()
	global_position = pos
	despawn_time = despawn
	movement_component.set_direction(Vector2.from_angle(rot))
	movement_component.set_speed(speed)
	collision_box_component.set_collision_count(initial_hit_count + atk_context.stat_upgrades.hit_count_bonus)
	collision_box_component.attack_context = atk_context
	$Sprite2D.global_rotation = rot
	
func _on_velocity_changed(new_velocity: Vector2) -> void:
	velocity = new_velocity
		
func return_to_pool():
	timer.stop()
	get_parent().remove_child(self)
	Pooling.return_entity(self)
	
func reset_state() -> void:
	movement_component.reset_state()
	collision_box_component.reset_state()
	
