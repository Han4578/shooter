extends Node2D
class_name TargetComponent

enum FromTargetType {MOUSE, TARGET, PLAYER, CLOSEST_ENEMY} 
enum ToTargetType {MOUSE, TARGET, PLAYER, CLOSEST_ENEMY, ORIENTATION} 

@export var target_from := FromTargetType.TARGET
@export var target_to := ToTargetType.MOUSE

signal target_direction(target: TargetComponent, offset: float, attributes: AttackContext)
signal target_position(from: Vector2, to: Vector2, attributes: AttackContext)

func _on_trigger(attack_context: AttackContext) -> void:
	target_direction.emit(self, 0, attack_context)
	target_position.emit(get_target_from_position(), get_target_to_position(), attack_context)
	
func get_target_from_position() -> Vector2:
	match target_from:
		FromTargetType.MOUSE: return get_global_mouse_position()
		FromTargetType.TARGET: return global_position
		FromTargetType.PLAYER: return Global.player.global_position
		#FromTargetType.CLOSEST_ENEMY: pass
		_: return Vector2.ZERO
	 
func get_target_to_position() -> Vector2:
	match target_to:
		ToTargetType.MOUSE: return get_global_mouse_position()
		ToTargetType.TARGET: return global_position
		ToTargetType.PLAYER: return Global.player.global_position
		#ToTargetType.CLOSEST_ENEMY: pass
		_: return Vector2.ZERO
	
func get_target_to_direction() -> float:
	if target_to == ToTargetType.ORIENTATION: return global_rotation
	return get_target_from_position().angle_to_point(get_target_to_position())
