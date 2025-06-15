extends Upgrade
	
var hit_effect := load("res://scenes/attachments/glove in a box/knockback_hit_effect.tres")

func apply_to_weapon(weapon: Weapon) -> void: 
	weapon.general_stat_upgrades.hit_effects.append(hit_effect)
	
func remove_from_weapon(weapon: Weapon) -> void:
	weapon.general_stat_upgrades.hit_effects.erase(hit_effect)
