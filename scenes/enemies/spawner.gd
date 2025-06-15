extends Node2D

var radius : int = 1000	
var radius2 : int = radius ** 2

var alien_scene := preload("res://scenes/enemies/alien/alien.tscn")

func calc_pos(x : float):
	return sqrt(radius2 - (x - Global.player.position.x) ** 2) * (1 if (randf() > 0.5) else -1) + Global.player.position.y

func _on_timer_timeout() -> void:
	var x : float = randf_range(-radius, radius) + Global.player.position.x
	var y = calc_pos(x)
	var alien = alien_scene.instantiate()
	alien.position = Vector2(x, y)
	add_sibling(alien)
	pass # Replace with function body.
