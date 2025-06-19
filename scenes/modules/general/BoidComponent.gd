extends Area2D
class_name BoidComponent

@export var movement_component: MovementComponent
@export var moves_aside := true
@onready var frame = Engine.get_physics_frames() % 5
@export var radius := 35

var current_v := Vector2.ZERO
var final_v := Vector2.ZERO

func _ready() -> void:
	input_pickable = false
	radius *= radius

func _physics_process(delta: float) -> void:	
	if moves_aside and Engine.get_physics_frames() % 5 == frame: 
		avoid_boids()
		
	if current_v.is_equal_approx(final_v): return
	current_v = current_v.lerp(final_v, 0.3)
	movement_component.set_boid_vector(current_v)

func avoid_boids() -> void:
	var separation := Vector2.ZERO
	var count := 0
	
	for area: BoidComponent in get_overlapping_areas():
		separation += max(0, 1 - (area.global_position.distance_squared_to(global_position) / radius)) * area.global_position.direction_to(global_position)
		count += 1
	
	final_v = separation.limit_length(1) * 2
	
