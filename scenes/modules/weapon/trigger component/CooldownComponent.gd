extends Timer
class_name CooldownComponent

@export var trigger_component: TriggerComponent

signal cd_end(trigger: TriggerComponent)

func _on_timeout() -> void:
	cd_end.emit(trigger_component)
