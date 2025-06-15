extends HitEffect
class_name KnockbackHitEffect

enum source {OWNER, COLLISION}
@export var force := 1
@export var direction: source

func apply(node: Node2D, attack_context: AttackContext):
	if node is KnockbackComponent:
		var from: Vector2
		
		match direction:
			source.OWNER: from = attack_context.collision_position
			source.COLLISION: from = attack_context.owner_position
			
		node.apply_knockback(from.direction_to(node.global_position), force)
			
	
