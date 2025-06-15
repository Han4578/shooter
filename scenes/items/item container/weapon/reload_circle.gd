extends TextureProgressBar

var tween: Tween

func start(t: float):
	value = max_value
	if (tween): tween.kill()
	tween = create_tween()
	tween.tween_property(self, "value", 0, t)
	
func _on_cd_start(t: float) -> void:
	start(t) 

func _on_weapon_pause_progress(is_paused: bool) -> void:
	process_mode = Node.PROCESS_MODE_DISABLED if (is_paused) else Node.PROCESS_MODE_INHERIT
