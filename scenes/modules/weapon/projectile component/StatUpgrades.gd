extends Resource
class_name StatUpgrades

var cooldown_bonus := 0.0
var charge_bonus := 0.0
var accuracy_bonus := 0.0
var projectile_bonus := 0
var spread_projectile_bonus := 0
var rapid_projectile_bonus := 0
var radius_bonus := 0.0
#Future
#var base_damage_bonus_percentage := 0.0
#var base_damage_bonus_flat:= 0
var damage_bonus := 0.0
var crit_bonus := 0.0

var attributes := {}
var extra := {}

@export var collision_effects: Array[CollisionEffect] = []
@export var hit_effects: Array[HitEffect] = []

func add_effects(collision: Array[CollisionEffect], hit: Array[HitEffect]) -> void:
	collision_effects.append_array(collision)
	hit_effects.append_array(hit)

func add_to_stats(stat_upgrades: StatUpgrades) -> void:
	cooldown_bonus += stat_upgrades.cooldown_bonus
	charge_bonus += stat_upgrades.charge_bonus
	accuracy_bonus += stat_upgrades.accuracy_bonus
	projectile_bonus += stat_upgrades.projectile_bonus
	spread_projectile_bonus += stat_upgrades.spread_projectile_bonus
	rapid_projectile_bonus += stat_upgrades.rapid_projectile_bonus
	damage_bonus += stat_upgrades.damage_bonus
	crit_bonus += stat_upgrades.crit_bonus
	
	collision_effects.append_array(stat_upgrades.collision_effects)
	hit_effects.append_array(stat_upgrades.hit_effects)
	
	attributes.merge(stat_upgrades.attributes)
	
	for key in stat_upgrades.extra:
		if key in extra: extra[key] += stat_upgrades.extra[key]
		else: extra[key] = stat_upgrades.extra[key]
		
