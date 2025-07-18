extends Component
class_name EffectComponent

signal effect_applied(hit_effect: HitEffect, attack_context: AttackContext)

func _on_effect_applied(hit_effect: HitEffect, attack_context: AttackContext) -> void:
	super(hit_effect, attack_context)
	effect_applied.emit(hit_effect, attack_context)
