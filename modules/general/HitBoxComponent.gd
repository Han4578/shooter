extends Area2D
class_name HitBoxComponent

var can_collide = true

signal damage_taken(damage: float, attack_context: AttackContext)
signal effect_applied(effect: Effect, attack_context: AttackContext)

func _physics_process(delta: float) -> void:
	_check_for_collision()

func _on_death() -> void:
	can_collide = false
	set_deferred("monitorable", false)
	
func _check_for_collision() -> void:
	pass
	
func reset_state() -> void:
	can_collide = true
	set_deferred("monitorable", true)

func take_damage(damage: float, attack_context: AttackContext) -> void:
	damage_taken.emit(damage, attack_context)
	
func apply_effect(effect: HitEffect, attack_context: AttackContext) -> void:
	effect_applied.emit(effect, attack_context)
