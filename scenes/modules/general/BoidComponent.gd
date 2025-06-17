extends Node2D
class_name BoidComponent

@export var movement_component: MovementComponent
@export var radius := 10
const factor := 5
@onready var frame = Engine.get_physics_frames() % 5
@onready var r2 := radius ** 2


func _physics_process(delta: float) -> void:		
	if Engine.get_physics_frames() % 5 == frame:
		avoid_boids()

#func avoid_boids() -> void:
	#var direction := Vector2.ZERO
	#var count := 0
	#
	#for area: Node2D in get_overlapping_areas():
		#direction += area.global_position.direction_to(global_position) / global_position.distance_squared_to(area.global_position)
		#count += 5
	#
	#movement_component.set_extra_vector(direction.normalized() * count)
	
func avoid_boids() -> void:
	var direction := Vector2.ZERO
	var count := 0
	
	for area: Node2D in HashGrid.get_area(HashGrid.Layers.BOID, global_position, radius):
		if area == self: continue
		var dist := global_position.distance_squared_to(area.global_position)
		if dist > r2: continue
		direction += area.global_position.direction_to(global_position) / dist
		count += 5
	
	movement_component.set_extra_vector(direction.normalized() * count)
