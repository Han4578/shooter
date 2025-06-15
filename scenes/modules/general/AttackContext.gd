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
	
	
