extends Control

@onready var pause_menu := $PauseMenu
@onready var inventory_menu := $InventoryMenu
@onready var pause_shade := $PauseShade


func _ready() -> void:
	Global.pause.connect(_on_pause)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"): 	
		toggle_menu(pause_menu)
	elif event.is_action_pressed("open_inventory"):
		toggle_menu(inventory_menu)
		
func _on_pause(is_paused: bool):
	pause_shade.visible = is_paused
	
func close_all_menus():
	pause_menu.visible = false
	inventory_menu.visible = false
	InventoryManager.close_weapon_details.emit()
	
func toggle_menu(node: Control):
	if node.visible:
		close_all_menus()
		Global.toggle_pause(false)
	else:		
		close_all_menus()
		node.visible = true
		Global.toggle_pause(true)

func _on_resume_pressed() -> void:
	pause_menu.visible = true
	inventory_menu.visible = true
	pause_shade.visible = true

func _on_inventory_menu_pressed() -> void:
	pause_menu.visible = false
	pause_shade.visible = true
	inventory_menu.visible = true
