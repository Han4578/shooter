extends Label

var score := 0.0
var scoretxt := "Score: "
@export var multiplier := 1.0

func _ready() -> void:
	Global.death.connect(update_score)

func update_score(entity: CharacterBody2D):
	score += entity.score * multiplier
	text = scoretxt + str(score)
