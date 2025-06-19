extends Node

var pool := {}

func get_entity(scene: PackedScene) -> Node2D:
	if scene.resource_path in pool and pool[scene.resource_path].size() > 0: return pool[scene.resource_path].pop()
	else: return scene.instantiate()
	
func return_entity(node: Node2D):
	pool.get_or_add(node.scene_file_path, []).append(node)
