extends Component
class_name MovementComponent

@export var speed := 100
var direction: Vector2
var knockback_vector := Vector2.ZERO
var extra_vector:= Vector2.ZERO

signal velocity_changed(new_velocity: Vector2)

func change_velocity():
	velocity_changed.emit(direction * speed + knockback_vector + extra_vector)
	
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	change_velocity()
	
func set_speed(new_speed: int) -> void:
	speed = new_speed
	change_velocity()
	
func set_knockback_vector(new_knockback_vector: Vector2) -> void:
	knockback_vector = new_knockback_vector
	change_velocity()
	
func add_extra_vector(new_extra_vector: Vector2) -> void:
	extra_vector += new_extra_vector
	change_velocity()
	
func set_extra_vector(new_extra_vector: Vector2) -> void:
	extra_vector = new_extra_vector
	change_velocity()
	
func add_knockback_vector(new_knockback_vector: Vector2) -> void:
	knockback_vector += new_knockback_vector
	change_velocity()
