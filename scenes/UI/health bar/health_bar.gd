extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.health_changed.connect(_on_health_changed)
	Global.max_health_changed.connect(_on_max_health_changed)

func _on_health_changed(new_hp : int) -> void:
	create_tween().tween_property(self, "value", new_hp, 0.5)

func _on_max_health_changed(new_hp : int) -> void:
	max_value = new_hp
	
