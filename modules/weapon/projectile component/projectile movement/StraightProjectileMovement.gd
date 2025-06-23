extends ProjectileMovement
class_name StraightProjectileMovement

@export var projectile_speed := 0.0

func move(node: Projectile, delta: float):
	node.position += Vector2.RIGHT.rotated(node.rotation) * projectile_speed * delta
