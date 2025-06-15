extends Node2D
class_name KnockbackComponent

@export var movement_component: MovementComponent
@export var weight := 1
var unit := 50

func _physics_process(_delta: float) -> void:
	if not movement_component.knockback_vector.is_zero_approx(): 
		movement_component.add_knockback_vector(-movement_component.knockback_vector.normalized())

func apply_knockback(direction: Vector2, force: int) -> void:
	movement_component.add_knockback_vector(direction * unit * (force - weight))
