extends Component
class_name TrackingComponent

enum Target {PLAYER, ALLY, ENEMY}
@export var target: Target
@export var change_every_process := false
@onready var frame := Engine.get_physics_frames() % 20
@export var track_every_frame := true

signal direction_changed(new_direction: Vector2)

func _ready() -> void:
	set_process(change_every_process)

func _physics_process(_delta: float) -> void:
	if track_every_frame or Engine.get_physics_frames() % 20 == frame:
		change_target()
			
func change_target():
		match target:
			Target.PLAYER: 
				direction_changed.emit(global_position.direction_to(Global.player.global_position))
			Target.ALLY:
				direction_changed.emit(global_position.direction_to(find_closest(Pooling.EntityTypes.ALLY).global_position))
			Target.ENEMY:
				direction_changed.emit(global_position.direction_to(find_closest(Pooling.EntityTypes.ENEMY).global_position))
				
func find_closest(entity_type: Pooling.EntityTypes) -> Node2D:
	var closest : Node2D = self
	var dist := INF
	for entity: Node2D in Pooling.entities[entity_type]:
		var d := global_position.distance_squared_to(entity.global_position)
		if d < dist: 
			closest = entity
			dist = d
	return closest
	
func start_tracking():
	set_process(true)
	
func stop_tracking():
	set_process(false)
	
