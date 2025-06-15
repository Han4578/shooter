extends Node2D
class_name TrackingComponent

enum Target {PLAYER, ALLY, ENEMY}
@export var target: Target
@export var change_every_process := false

var start_tracking:
	set(val):
		set_physics_process(val and change_every_process)

signal direction_changed(new_direction: Vector2)

func _ready() -> void:
	set_physics_process(change_every_process)

func _physics_process(_delta: float) -> void:
	change_target()
			
func change_target():
		match target:
			Target.PLAYER: 
				direction_changed.emit(global_position.direction_to(Global.player.global_position))
			Target.ALLY:
				direction_changed.emit(global_position.direction_to(find_closest(&"Ally").global_position))
			Target.ENEMY:
				direction_changed.emit(global_position.direction_to(find_closest(&"Enemy").global_position))
				
func find_closest(group_name: StringName) -> Node2D:
	var closest : Node2D = self
	var dist := INF
	for entity: Node2D in get_tree().get_nodes_in_group(group_name):
		var d := global_position.distance_squared_to(entity.global_position)
		if d < dist: 
			closest = entity
			dist = d
	return closest
	
