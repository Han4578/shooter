extends Node2D
class_name NumberGenerator

var velocity : Vector2
const gravity := 500

const scene := preload("res://scenes/general/damage number/damage_number.tscn")
static var number_layer: Node2D

func _enter_tree() -> void:
	velocity = Vector2.from_angle(randf_range(1.25, 1.75) * PI) * randf_range(250, 300)
	$Timer.call_deferred(&"start")


func _physics_process(delta: float) -> void:
	position += velocity * delta
	velocity.y += gravity * delta
	
	
func _on_timer_timeout() -> void:
	get_parent().remove_child(self)
	Pooling.return_entity(self)
	

func _set_number(number: int) -> void:
	$Label.text = str(number)
	
	
static func output_number(pos: Vector2, number: int):
	var instance: NumberGenerator = Pooling.get_entity(scene)
	
	instance._set_number(number)
	instance.global_position = pos
	number_layer.add_child(instance)
	
	
	
	
