extends Area2D
class_name HitBoxComponent

var can_collide = true

signal damage_taken(damage: float, attack_context: AttackContext)
signal apply_status()

func _on_death() -> void:
	can_collide = false

func take_damage(damage: float, attack_context: AttackContext) -> void:
	damage_taken.emit(damage, attack_context)
