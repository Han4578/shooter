extends BarrelComponent
class_name SpreadBarrelComponent

@export var even_spread := false
@export_range(0, 360, 0.01) var spread := 60.0
@export_category("Upgrades")
@export var accuracy_bonus := 1.0

signal trigger(target: TargetComponent, offset: float, attack_context: AttackContext)

func _on_trigger(target: TargetComponent, offset: float, attack_context: AttackContext):
	attack_context.stat_upgrades.tags[SpreadBarrelComponent] = true
	var total_projectile_count := projectile_count + attack_context.stat_upgrades.projectile_bonus + attack_context.stat_upgrades.spread_projectile_bonus
	if even_spread:
		if total_projectile_count <= 1: trigger.emit(target, offset) 
		else:
			var gap :=  spread / (total_projectile_count - 1)
			var angle := -spread / 2
			var max_angle := spread / 2
			for i in total_projectile_count:
				trigger.emit(target, deg_to_rad(angle) + offset, attack_context)
				angle += gap
	else:
		for i in total_projectile_count:
			trigger.emit(target, randfn(offset, deg_to_rad(spread / 6)), attack_context)
		
