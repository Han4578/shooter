extends CharacterBody2D
class_name BodyComponent

var stat_upgrades := StatUpgrades.new()
@export var entity_type: Pooling.EntityTypes
@export var stats_component: StatsComponent


func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func _enter_tree() -> void:
	Pooling.entities[entity_type][self] = null

func reset_state() -> void:
	for node: Node2D in get_children(true):
		if node.has_method(&"reset_state"): node.reset_state()
	
func _on_velocity_changed(new_velocity: Vector2):
	velocity = new_velocity

func _on_death() -> void:
	get_parent().remove_child(self)
	Pooling.entities[entity_type].erase(self)
	Pooling.return_entity(self)
	reset_state()

func create_attack_context() -> AttackContext:
	var attack_context := AttackContext.new()
	attack_context.stat_upgrades.add_to_stats(stat_upgrades)
	attack_context.owner = self
	attack_context.owner_position = global_position
	stats_component.add_stats(attack_context)
	return attack_context

func _on_attack_context_requested(node: CollisionBoxComponent) -> void:
	node.attack_context = create_attack_context()
