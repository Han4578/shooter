extends Resource
class_name AttackContext

var attack: float
var defence: float
var health: float
var owner: BodyComponent
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
		pass
	##Todo
	
