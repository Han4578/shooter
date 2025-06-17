extends Component
class_name MovementComponent

@export var speed := 100
var direction: Vector2
var knockback_vector := Vector2.ZERO
var boid_vector:= Vector2.ZERO

signal velocity_changed(new_velocity: Vector2)

func change_velocity():
	velocity_changed.emit((direction + boid_vector).normalized() * speed + knockback_vector)
	
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	change_velocity()
	
func set_speed(new_speed: int) -> void:
	speed = new_speed
	change_velocity()
	
func set_knockback_vector(new_knockback_vector: Vector2) -> void:
	knockback_vector = new_knockback_vector
	change_velocity()
	
func add_boid_vector(new_boid_vector: Vector2) -> void:
	boid_vector += new_boid_vector
	change_velocity()
	
func set_boid_vector(new_boid_vector: Vector2) -> void:
	boid_vector = new_boid_vector
	change_velocity()
	
func add_knockback_vector(new_knockback_vector: Vector2) -> void:
	knockback_vector += new_knockback_vector
	change_velocity()
