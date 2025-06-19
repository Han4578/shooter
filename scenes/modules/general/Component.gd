extends Node2D
class_name Component

func reset_state() -> void: pass

func _on_effect_applied(hit_effect: HitEffect, attack_context: AttackContext) -> void:
	hit_effect.apply(self, attack_context)
