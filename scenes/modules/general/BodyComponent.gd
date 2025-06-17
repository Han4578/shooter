extends CharacterBody2D
class_name BodyComponent

var stat_upgrades := StatUpgrades.new()

@export var stats_component: StatsComponent

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _on_velocity_changed(new_velocity: Vector2):
	velocity = new_velocity

func _on_death() -> void:
	queue_free()

func create_attack_context() -> AttackContext:
	var attack_context := AttackContext.new()
	attack_context.stat_upgrades.add_to_stats(stat_upgrades)
	attack_context.owner = self
	attack_context.owner_position = global_position
	stats_component.add_stats(attack_context)
	return attack_context

func _on_attack_context_requested(node: CollisionBoxComponent) -> void:
	node.attack_context = create_attack_context()
