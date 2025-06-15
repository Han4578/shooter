extends InventorySlot
class_name WeaponSlot

@export var normal_frame: Resource
@export var selected_frame: Resource

var show_weapon := false
var is_passive := false
var index: int

var selected:
	set(val):
		$Frame.texture = selected_frame if (val) else normal_frame
		show_weapon = val
		change_visible()

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"change_active_passive_slot"):
		InventoryManager.change_passive(index)
		change_passive()
		
func _on_child_entered_tree(node: Node) -> void:
	if (node is WeaponItemContainer):
		super(node)
		node.start_process()
		Global.player.add_child(node.content)
		InventoryManager.weapons[index] = node.content
		change_visible()

func _on_child_exiting_tree(node: Node) -> void:
	if (node is WeaponItemContainer):
		super(node)
		node.stop_process()
		node.content.visible = false
		InventoryManager.weapons[index] = null
		Global.player.remove_child(node.content)
		
func change_visible() -> void:
	if occupied: get_child(-1).content.visible = show_weapon
		
func change_passive() -> void:
	is_passive = not is_passive
	$Frame.modulate = Color8(0, 80, 0) if is_passive else Color.WHITE
		

		
