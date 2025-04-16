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
var moxieVisited = false
var solarPanelVisited = false
var moxieInputVisited = false
var StormUnlocked = false

func _ready() -> void:
	moxie.stopMove.connect(stopTimers)
	moxieInput.stopMove.connect(stopTimers)
	solarPanel.stopMove.connect(stopTimers)
	moxie.stopMove.connect(player.stopMove)
	moxieInput.stopMove.connect(player.stopMove)
	solarPanel.stopMove.connect(player.stopMove)
	stopMove.connect(player.stopMove)
	oxygenTimer.connect(player.oxygenChange)
	hungerTimer.connect(player.hungerChange)
	$IntroText.visible = true

func _on_oxygen_timer_timeout():
	oxygenTimer.emit(1)

func _on_hunger_timer_timeout() -> void:
	hungerTimer.emit(1)

func _process(delta: float) -> void:
	if moxieVisited && (solarPanelVisited && moxieInputVisited):
		if not StormUnlocked:
			$Player/Camera2D/StaticBody2D/Timer.start()
			StormUnlocked = true

func _on_intro_text_close_requested() -> void:
	$OxygenTimer.start()
	$HungerTimer.start()
	stopMove.emit()
	$IntroText.hide()
	
func stopTimers() -> void:
	$OxygenTimer.stop()
	$HungerTimer.stop()

func _on_oxy_gen_start_storm() -> void:
	moxieVisited = true

func _on_solar_panel_start_storm() -> void:
	solarPanelVisited = true

func _on_moxie_input_start_storm() -> void:
	moxieInputVisited = true

func _on_player_health_changed(health:int) -> void:
	textureHealthBar.value = health

func _on_player_energy_changed(energy:int) -> void:
	textureEnergyBar.value = energy

func _on_player_hunger_changed(hunger:int) -> void:
	textureHungerBar.value = hunger

func _on_player_oxygen_changed(oxygen:int) -> void:
	textureOxygenBar.value = oxygen
