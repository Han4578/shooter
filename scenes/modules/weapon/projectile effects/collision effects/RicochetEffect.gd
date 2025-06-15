extends CollisionEffect
class_name RicochetProjectileEffect
#
#@export var richochet_count := 1
#const key := &"can_ricochet"
#
#func apply(projectile: Projectile): 
	#projectile.hit_count += richochet_count
	#if key not in projectile.effects_dict: projectile.effects_dict[key] = 1
	#else: projectile.effects_dict[key] += 1
	#if projectile.effects_dict[key] == 1:
		#projectile.collision.connect(_on_collision)
#
#func remove(projectile: Projectile): 
	#projectile.hit_count -= richochet_count
	#projectile.effects_dict[key] -= 1
	#if projectile.effects_dict[key] == 0: 
		#projectile.collision.disconnect(_on_collision)
	#
#func _on_collision(projectile: Projectile, hitbox: HitBoxComponent): 
	#var closest_enemy : Enemy
	#var closest_distance = INF
	#var hitbox_parent : Enemy = hitbox.get_parent()
	#for enemy: Enemy in projectile.get_tree().get_nodes_in_group(&"Enemy"):
		#if enemy == hitbox_parent: continue
		#var d := projectile.global_position.distance_squared_to(enemy.global_position)
		#if d < closest_distance:
			#closest_distance = d
			#closest_enemy = enemy
	#
	#if closest_enemy: projectile.rotation = projectile.global_position.angle_to_point(closest_enemy.global_position)
