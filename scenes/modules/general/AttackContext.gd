extends Resource
class_name AttackContext

var attack: float
var defence: float
var max_health: float
var owner: Node2D
var owner_position: Vector2
var collision_position: Vector2
var weapon: Weapon
var stat_upgrades := StatUpgrades.new()

func get_final_damage(scaling_parameter: ScalingParameter) -> float:
	return scaling_parameter.get_amount(self) * (1 + stat_upgrades.damage_bonus)
	
func collide(area: HitBoxComponent):
	for effect: CollisionEffect in stat_upgrades.collision_effects:
		effect.apply(area, self)
		
func hit(area: HitBoxComponent):
	for effect: HitEffect in stat_upgrades.hit_effects:
		area.apply_effect(effect, self)
		
func get_owner_position():
	return owner.global_position if is_instance_valid(owner) else owner_position
		
func get_attack():
	return owner.stats_component.total_attack if is_instance_valid(owner) else attack
		
func get_defence():
	return owner.stats_component.total_defence if is_instance_valid(owner) else defence
		
func get_max_health():
	return owner.stats_component.total_health if is_instance_valid(owner) else max_health
	
	
