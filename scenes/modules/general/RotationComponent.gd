extends Node2D
class_name RotationComponent

@export var horizontal_only := false
@export var follow_mouse := false

@export var sprite: Sprite2D

func _ready() -> void:
	set_process(follow_mouse)
	
func _process(delta: float) -> void:
	look_at_mouse()
			
func look_at_mouse() -> void:
	var mouse_pos := get_global_mouse_position()
	sprite.global_rotation = global_position.angle_to_point(mouse_pos)
	sprite.scale.y = 1 if (mouse_pos > global_position) else -1
	
func change_rotation(direction: Vector2) -> void:
	if direction == Vector2.ZERO: return
	if horizontal_only: 
		if direction.x != 0: sprite.scale.x = -1 if direction.x < 0 else 1
	else:
		sprite.global_rotation = direction.angle()
		if direction.x != 0: sprite.scale.y = -1 if direction.x < 0 else 1
