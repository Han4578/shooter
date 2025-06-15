extends Area2D
class_name CollisionBoxComponent

@export var refresh_context := false
@export var one_shot := false
@export var tick_speed := 0.2
@export_category("Effects")
@export var collision_effects: Array[CollisionEffect]
@export var hit_effects: Array[HitEffect]

signal attack_context_requested(node: CollisionBoxComponent)
signal area_collided()

var attack_context: AttackContext
var can_collide := true

func _ready() -> void:
	set_physics_process(refresh_context)
	
func _physics_process(_delta: float) -> void:
	attack_context = null

func _on_area_entered(area: Area2D) -> void:
	if not (area is HitBoxComponent and can_collide): return
	if not attack_context: 
		attack_context_requested.emit(self)
		attack_context.stat_upgrades.add_effects(collision_effects, hit_effects)
	
	attack_context.collide(area)
		
	area_collided.emit()
	
	if not one_shot:
		await get_tree().create_timer(tick_speed).timeout
		if is_instance_valid(area) and overlaps_area(area): _on_area_entered(area)
	
	
