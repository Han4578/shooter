extends Node2D

@onready var square : CollisionShape2D = $CollisionShape2D
const platform_scene := preload("./floor.tscn")
const width := 41 * 32

var platforms = []

var x : 
	get : return square.position.x
	set(n) : square.position.x = n

var y : 
	get : return square.position.y
	set(n) : square.position.y = n

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	square.shape.size = Vector2(width, width)
	
	for yy in range(-1, 2):
		var row = []
		for xx in range(-1, 2):
			var platform = platform_scene.instantiate()
			platform.position = Vector2(xx, yy) * width
			row.append(platform)
			add_child(platform)
		platforms.append(row)
	
func _on_body_exited(area: Node2D) -> void:
	var pos = area.global_position
	
	if (pos.x > x + (width >> 1)):
		for row : Array in platforms:
			row[0].position.x += width * 3
			row.push_back(row.pop_front())
		x += width
	elif (pos.x < x - (width >> 1)):
		for row : Array in platforms:
			row[-1].position.x -= width * 3
			row.push_front(row.pop_back())
		x -= width
	
	if (pos.y > y + (width >> 1)): #went down
		for platform in platforms[0]:
			platform.position.y += width * 3
		platforms.push_back(platforms.pop_front())
		y += width
	elif (pos.y < y - (width >> 1)): #went up
		for platform in platforms[-1]:
			platform.position.y -= width * 3
		platforms.push_front(platforms.pop_back())
		y -= width
