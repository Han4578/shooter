extends Node2D

var radius : int = 1500	
var radius2 : int = radius ** 2


var alien_scene := preload("res://scenes/enemies/alien/alien.tscn")

func calc_pos(x : float):
	return sqrt(radius2 - (x - Global.player.position.x) ** 2) * (1 if (randf() > 0.5) else -1) + Global.player.position.y

func _on_timer_timeout() -> void:
	spawn_alien()
	
func spawn_alien():
	var x : float = randf_range(-radius, radius) + Global.player.position.x
	var y = calc_pos(x)
	var alien := Pooling.get_entity(alien_scene)
	alien.position = Vector2(x, y)
	add_sibling(alien)
	
	
#var count := 0
#func _physics_process(delta: float) -> void:
	#spawn_alien()
	#count += 1
	#if count == 600: set_physics_process(false)
	
