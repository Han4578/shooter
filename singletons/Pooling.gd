extends Node

enum EntityTypes {ALLY = 0, ENEMY = 1, BOID = 2}

const ALLY_ENTITY := EntityTypes.ALLY
const ENEMY_ENTITY := EntityTypes.ENEMY
const BOID_ENTITY := EntityTypes.BOID

var entities: Array[Dictionary] = [{}, {}, {}]

var pool := {}

func get_entity(scene: PackedScene) -> Node2D:
	if scene.resource_path in pool and not pool[scene.resource_path].is_empty(): return pool[scene.resource_path].pop_back()
	else: return scene.instantiate()
	
func return_entity(node: Node2D):
	pool.get_or_add(node.scene_file_path, []).append(node)
