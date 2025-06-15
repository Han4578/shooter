extends Resource
class_name Collectible

enum Rarity {COMMON, RARE, EPIC, LEGENDARY}

@export var icon: Texture

func pick_up() -> void: pass
