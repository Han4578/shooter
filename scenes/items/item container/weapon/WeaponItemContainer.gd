extends ItemContainer
class_name WeaponItemContainer

var content: Weapon
var details: WeaponItem

var attachments: Array[UpgradeItemContainer] = [null, null, null, null]

func _init() -> void:
	type = InventoryManager.ItemTypes.WEAPON

func _ready() -> void:
	super()
	content.cd_start.connect($ProgressBar._on_cd_start)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		InventoryManager.open_weapon_details.emit(self)

func start_process():
	$ProgressBar.process_mode = Node.PROCESS_MODE_PAUSABLE
		
func stop_process():
	$ProgressBar.process_mode = Node.PROCESS_MODE_DISABLED
