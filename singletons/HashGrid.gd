extends Node

var enemies: Dictionary[Vector2, Array] = {}
const GRID_SIZE := 80
const ENEMY_HITBOX_RADIUS := 45
const ENEMY_HITBOX_DIAGONAL := Vector2(ENEMY_HITBOX_RADIUS, ENEMY_HITBOX_RADIUS)
var enemy_hitbox_shape := CircleShape2D.new()

func _ready() -> void:
	enemy_hitbox_shape.radius = ENEMY_HITBOX_RADIUS

func _physics_process(_delta: float) -> void:
	enemies.clear()
	for enemy: BodyComponent in Pooling.entities[Pooling.ENEMY_ENTITY]:
		enemies.get_or_add(to_cell(enemy.position), []).append(enemy)
		
func _get_enemies_in_grids(from: Vector2, to: Vector2) -> Array[BodyComponent]:
	var start_cell := to_cell(from)
	var end_cell := to_cell(to)
	var current_cell := Vector2(start_cell)
	var container: Array[BodyComponent] = []
	
	for y in end_cell.y - start_cell.y + 1:
		current_cell.x = start_cell.x
		for x in end_cell.x - start_cell.x + 1:
			if current_cell in enemies: 
				container.append_array(enemies[current_cell])
			current_cell.x += 1
		current_cell.y += 1
		
	return container
	
func _get_enemies_in_ring(origin_cell: Vector2, offset: int) -> Array[BodyComponent]:
	var direction := Vector2.RIGHT
	var current_cell := Vector2(origin_cell.x - offset, origin_cell.y - offset)
	var container: Array[BodyComponent] = []
	
	for i in 4:
		for j in offset * 2:
			if current_cell in enemies:
				container.append_array(enemies[current_cell])
			current_cell += direction
		direction = Vector2(-direction.y, direction.x)	
	
	return container
	
func _get_closest_from_array(origin: Vector2, arr: Array[BodyComponent]) -> BodyComponent:
	var closest: BodyComponent = null
	var dist := INF
	
	for enemy: BodyComponent in arr:
		var d := enemy.position.distance_squared_to(origin)
		if d < dist:
			dist = d
			closest = enemy
			
	return closest
		
func to_cell(at: Vector2) -> Vector2:
	return floor(at / GRID_SIZE)
	
func get_closest(origin: Vector2) -> BodyComponent:
	if Pooling.entities[Pooling.ENEMY_ENTITY].size() < 30: return _get_closest_from_array(origin, Pooling.entities[Pooling.ENEMY_ENTITY].keys())
	
	var origin_cell := to_cell(origin)
	@warning_ignore("integer_division")
	for offset in 1000 / GRID_SIZE:
		var enemy_ring := _get_enemies_in_ring(origin_cell, offset)
		
		if not enemy_ring.is_empty(): return _get_closest_from_array(origin, enemy_ring)
			
	return null
	
func get_all_overlapping(shape: Shape2D, transform: Transform2D) -> Array[BodyComponent]:
	var rect := shape.get_rect()
	rect = Rect2(transform.origin - rect.size / 2, rect.size)
	var potential_enemies := _get_enemies_in_grids(rect.position - ENEMY_HITBOX_DIAGONAL, rect.end + ENEMY_HITBOX_DIAGONAL)
	
	return potential_enemies.filter(func(enemy: BodyComponent): return shape.collide(transform, enemy_hitbox_shape, enemy.global_transform))
	
func is_colliding(shape: Shape2D, transform: Transform2D, enemy: BodyComponent) -> bool:
	return shape.collide(transform, enemy_hitbox_shape, enemy.global_transform)
