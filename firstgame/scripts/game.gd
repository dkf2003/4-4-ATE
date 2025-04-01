extends Node2D

@onready var textureHealthBar = $Player/Camera2D/Node2D/TextureHealthBar
@onready var player = $Player

func _ready() -> void:
	player.healthChanged.connect(textureHealthBar.updateHealth)

func _process(delta: float) -> void:
	pass
