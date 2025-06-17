extends Area2D
class_name BoidComponent

@export var movement_component: MovementComponent
@export var moves_aside := true
@onready var frame = Engine.get_physics_frames() % 5

var current_v := Vector2.ZERO
var final_v := Vector2.ZERO

func _physics_process(delta: float) -> void:	
	if moves_aside and Engine.get_physics_frames() % 5 == frame: avoid_boids()
		
	if current_v.is_equal_approx(final_v): return
	current_v = current_v.lerp(final_v, 0.3)
	movement_component.set_boid_vector(current_v)

func avoid_boids() -> void:
	var direction := Vector2.ZERO
	var count := 0
	
	for area: BoidComponent in get_overlapping_areas():
		direction += area.global_position.direction_to(global_position) / global_position.distance_squared_to(area.global_position)
		count += 1
	
	final_v = direction.normalized() * count * count
	
