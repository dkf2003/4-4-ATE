extends Node2D

@onready var textureHealthBar = $Player/Camera2D/Node2D/TextureHealthBar
@onready var textureEnergyBar = $Player/Camera2D/Node2D/TextureEnergyBar
@onready var textureOxygenBar = $Player/Camera2D/Node2D/TextureOxygenBar
@onready var textureHungerBar = $Player/Camera2D/Node2D/TextureHungerBar
@onready var player = $Player
@onready var moxie = $OxyGen
@onready var moxieInput = $MOXIEInput
@onready var solarPanel = $SolarPanel
signal oxygenTimer
signal hungerTimer
signal stopMove

func _ready() -> void:
	player.healthChanged.connect(textureHealthBar.updateHealth)
	player.energyChanged.connect(textureEnergyBar.updateEnergy)
	player.oxygenChanged.connect(textureOxygenBar.updateOxygen)
	player.hungerChanged.connect(textureHungerBar.updateHunger)
	moxie.stopMove.connect(player.stopMove)
	moxieInput.stopMove.connect(player.stopMove)
	solarPanel.stopMove.connect(player.stopMove)
	stopMove.connect(player.stopMove)
	oxygenTimer.connect(player.oxygenChange)
	hungerTimer.connect(player.hungerChange)

func _on_oxygen_timer_timeout():
	oxygenTimer.emit(1)

func _on_hunger_timer_timeout() -> void:
	hungerTimer.emit(1)

func _process(delta: float) -> void:
	pass

func _on_intro_text_close_requested() -> void:
	$OxygenTimer.start()
	$HungerTimer.start()
	stopMove.emit()
	$IntroText.hide()
