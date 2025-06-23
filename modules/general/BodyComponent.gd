extends Node2D
class_name BodyComponent

var stat_upgrades := StatUpgrades.new()
var velocity := Vector2.ZERO
var can_collide := true
@export var entity_type: Pooling.EntityTypes
@export var stats_component: StatsComponent

signal damage_taken
signal effect_applied

func _physics_process(delta: float) -> void:
	position += velocity * delta
	
func _enter_tree() -> void:
	Pooling.entities[entity_type][self] = Pooling.entities[entity_type].size()
	reset_state()

func reset_state() -> void:
	can_collide = true
	for node: Node2D in get_children(true):
		if node.has_method(&"reset_state"): node.reset_state()
	
func _on_velocity_changed(new_velocity: Vector2):
	velocity = new_velocity

func _on_death() -> void:
	can_collide = false
	call_deferred(&"return_to_pool")
	
func return_to_pool():
	Pooling.entities[entity_type].erase(self)
	get_parent().remove_child(self)
	Pooling.return_entity(self)

func _on_attack_context_requested(node: CollisionBoxComponent) -> void:
	node.attack_context = create_attack_context()

func create_attack_context() -> AttackContext:
	var attack_context := AttackContext.new()
	attack_context.stat_upgrades.add_to_stats(stat_upgrades)
	attack_context.owner = self
	attack_context.owner_position = global_position
	stats_component.add_stats(attack_context)
	return attack_context
	
func take_damage(damage: float, attack_context: AttackContext) -> void:
	damage_taken.emit(damage, attack_context)
	
func apply_effect(effect: HitEffect, attack_context: AttackContext) -> void:
	effect_applied.emit(effect, attack_context)
