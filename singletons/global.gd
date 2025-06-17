extends Node2D

var player : CharacterBody2D
var map : Node2D

enum WeaponTags {RAPID, SPREAD, AERIAL, GROUND, CHARGE, STACK, RANGED, MELEE, AOE, PIERCING}

signal pause(_is_paused: bool)
signal update_score(points: int)
signal health_changed(new_health: int)
signal max_health_changed(new_health: int)
signal death(killed: CharacterBody2D)

var entities = {}
		
func _input(event: InputEvent) -> void:
	if player: player.process_input(event)
	
func toggle_pause(is_paused: bool = not get_tree().paused):
	get_tree().paused = is_paused
	pause.emit(is_paused)
	
