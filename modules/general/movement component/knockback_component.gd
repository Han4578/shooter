extends Component
class_name KnockbackComponent

@export var movement_component: MovementComponent
@export var weight := 1
const knock_unit := 250
const reduction_unit := 20

func _physics_process(_delta: float) -> void:
	if not movement_component.knockback_vector.is_zero_approx(): 
		movement_component.set_knockback_vector(movement_component.knockback_vector.move_toward(Vector2.ZERO, reduction_unit))

func apply_knockback(direction: Vector2, force: int) -> void:
	if force >= weight: movement_component.add_knockback_vector(direction * knock_unit * (force - weight + 1))
