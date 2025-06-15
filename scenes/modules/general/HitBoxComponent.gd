extends Area2D
class_name HitBoxComponent

var can_collide = true

signal damage_taken(damage: float, attack_context: AttackContext)
signal effect_applied(effect: Effect, attack_context: AttackContext)

func _on_death() -> void:
	can_collide = false

func take_damage(damage: float, attack_context: AttackContext) -> void:
	damage_taken.emit(damage, attack_context)
	
func apply_effect(effect: Effect, attack_context: AttackContext) -> void:
	effect_applied.emit(effect, attack_context)
