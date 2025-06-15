extends Control
class_name ItemContainer

var icon: Texture
var type: InventoryManager.ItemTypes

func _ready() -> void:
	$Sprite.texture = icon

func _get_drag_data(at_position: Vector2) -> Variant:
	if (not get_tree().paused): return null
	set_drag_preview(make_drag_preview(at_position))
	return self
	
func make_drag_preview(at_position: Vector2):
	var c := Control.new()
	var texture_rect = TextureRect.new()
	texture_rect.texture = icon
	texture_rect.position = -at_position
	c.add_child(texture_rect)
	c.modulate.a = 0.8
	c.z_index = 2
	return c
