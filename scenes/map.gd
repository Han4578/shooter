extends Node2D

func _ready() -> void:
	Global.map = self
	ParticleGenerator.particle_layer = $"Particle Layer"
	NumberGenerator.number_layer = $"Particle Layer"
