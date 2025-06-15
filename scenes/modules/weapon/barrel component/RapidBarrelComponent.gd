extends BarrelComponent
class_name RapidBarrelComponent

@export var interval := 0.2
@export_range(0, 360, 0.01) var spread := 60.0

signal trigger(target : TargetComponent, offset: float, attack_context: AttackContext)

func _on_trigger(target: TargetComponent, offset: float, attack_context: AttackContext) -> void:
	attack_context.stat_upgrades.attributes[RapidBarrelComponent] = true
	var total_projectile_count := projectile_count + attack_context.stat_upgrades.projectile_bonus + attack_context.stat_upgrades.rapid_projectile_bonus
	var updated_offset := randfn(offset, spread / 6)
	for i in total_projectile_count:
		trigger.emit(target, updated_offset, attack_context)
		await get_tree().create_timer(interval).timeout
	
	
