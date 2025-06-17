extends HitEffect
class_name KnockbackHitEffect

enum Point {OWNER, COLLISION, SELF}
@export var force := 1
@export var from: Point
@export var to: Point

func apply(node: Node2D, attack_context: AttackContext):
	if node is KnockbackComponent:
		node.apply_knockback(get_pos(from, node, attack_context).direction_to(get_pos(to, node, attack_context)), force)
		
func get_pos(of: Point, node: Node2D, attack_context: AttackContext) -> Vector2:
	match of:
		Point.OWNER: return attack_context.get_owner_position()
		Point.COLLISION: return attack_context.collision_position
		Point.SELF: return node.global_position
		_: return Vector2.ZERO
	
			
	
