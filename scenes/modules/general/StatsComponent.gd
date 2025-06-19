extends Component
class_name StatsComponent

@export_group(&"Attack Modifiers", &"attack_")
@export var attack_base := 0.0
@export var attack_percentage_bonus := 1.0
@export var attack_flat_bonus := 0.0
var total_attack := 0.0
@export_group(&"Defence Modifiers", &"defence_")
@export var defence_base := 0.0
@export var defence_percentage_bonus := 1.0
@export var defence_flat_bonus := 0.0
var total_defence := 0.0
@export_group(&"Health Modifiers", &"health_")
@export var health_base := 0.0
@export var health_percentage_bonus := 1.0
@export var health_flat_bonus := 0.0
var total_health := 0.0
var current_health_percentage := 1.0

signal death()

func _ready() -> void:
	update_total_defence()
	update_total_attack()
	update_total_health()
	
func reset_state() -> void: 
	current_health_percentage = 1.0
	
func _on_damage_taken(damage: float, _attack_context: AttackContext) -> void:		
	damage = max(1, damage - total_defence)
	
	ParticleGenerator.display_damage(round(damage), global_position)
	var remaining_health := total_health * current_health_percentage - damage
	if remaining_health <= 0:
		death.emit()
	current_health_percentage = remaining_health / total_health

func update_total_defence() -> void:
	total_defence = (defence_base + defence_flat_bonus) * defence_percentage_bonus

func update_total_health(): 
	total_health = (health_base + health_flat_bonus) * health_percentage_bonus
	
func update_total_attack(): 
	total_attack = (attack_base + attack_flat_bonus) * attack_percentage_bonus
	
func add_stats(attack_context: AttackContext):
	attack_context.attack = total_attack
	attack_context.defence = total_defence
	attack_context.max_health = total_health
	
