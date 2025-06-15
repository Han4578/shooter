extends StatsComponent

func _ready() -> void:
	super()
	Global.max_health_changed.emit(ceil(total_health))

func _on_damage_taken(damage: float, attack_context: AttackContext):
	super(damage, attack_context)
	Global.health_changed.emit(ceil(total_health * current_health_percentage))
