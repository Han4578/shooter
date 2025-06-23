extends Node2D
class_name CollisionBoxComponent

@export var refresh_context := false
@export var one_shot := false
@export var tick_speed := 0.2
@export var shape: Shape2D
@export_category("Effects")
@export var collision_effects: Array[CollisionEffect]
@export var hit_effects: Array[HitEffect]

var collision_count := INF

signal attack_context_requested(node: CollisionBoxComponent)
signal collision_depleted()

var attack_context: AttackContext
var can_collide := true
	
func _physics_process(_delta: float) -> void:
	if refresh_context: attack_context = null
	_check_for_collision()

		
func _check_for_collision() -> void:
	var enemies := HashGrid.get_all_overlapping(shape, global_transform)
	if enemies.is_empty(): return
	
	if not attack_context: 
		attack_context_requested.emit(self)
		attack_context.stat_upgrades.add_effects(collision_effects, hit_effects)
	
	for enemy in enemies:
		collide(enemy)
		if not can_collide: 
			break
		
func collide(enemy: BodyComponent) -> void:
	if not enemy.can_collide: return

	attack_context.collision_position = (global_position + enemy.global_position) / 2
	attack_context.collide(enemy)
	collision_count -= 1
		
	if collision_count == 0: 
		collision_depleted.emit()
		can_collide = false
	
	elif not one_shot:
		await get_tree().create_timer(tick_speed, false).timeout
		if can_collide and enemy in Pooling.entities[Pooling.ENEMY_ENTITY] and HashGrid.is_colliding(shape, global_transform, enemy): 
			collide(enemy)
	
func set_collision_count(count: int) -> void:
	collision_count = count	
		
func reset_state() -> void:
	attack_context = null
	can_collide = true	
	collision_count = INF
	
