extends ItemContainer
class_name WeaponItemContainer

var content: Weapon

func _init() -> void:
	type = InventoryManager.ItemTypes.WEAPON

func _ready() -> void:
	super()
	content.cd_start.connect($ProgressBar._on_cd_start)

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"left_click"):
		Global.open_item_details.emit(self)

func start_process():
	$ProgressBar.process_mode = Node.PROCESS_MODE_PAUSABLE
		
func stop_process():
	$ProgressBar.process_mode = Node.PROCESS_MODE_DISABLED
