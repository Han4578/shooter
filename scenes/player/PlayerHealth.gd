extends HealthComponent


func _ready() -> void:
	super()	
	Global.max_health_changed.emit(round(max_health))
	
func _on_damage_taken(damage: float, attack_context: AttackContext) -> void:
	super(damage, attack_context)
	Global.health_changed.emit(round(max_health * current_health_percentage))
