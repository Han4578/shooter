extends Timer
class_name CooldownComponent

@export var trigger_component: TriggerComponent

signal cd_ended(trigger: TriggerComponent)

func _ready() -> void:
	timeout.connect(_on_timeout)

func _on_timeout() -> void:
	cd_ended.emit(trigger_component)
