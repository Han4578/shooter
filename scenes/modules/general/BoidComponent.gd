extends Component
class_name BoidComponent

@export var movement_component: MovementComponent
var current_v: Vector2
var final_v: Vector2

func  _physics_process(_delta: float) -> void:
	if current_v.is_equal_approx(final_v): return
	current_v = current_v.lerp(final_v, 0.3)
	movement_component.set_boid_vector(current_v)	


func _on_death() -> void:
	Pooling.entities[Pooling.EntityTypes.BOID].erase(self)


func reset_state() -> void:
	Pooling.entities[Pooling.EntityTypes.BOID][self] = null
	
	
func set_final_velocity(new_velocity: Vector2) -> void:
	final_v = new_velocity
