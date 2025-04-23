extends Node2D

@onready var textureHealthBar = $Player/Camera2D/CanvasLayer/TextureHealthBar
@onready var textureEnergyBar = $Player/Camera2D/CanvasLayer/TextureEnergyBar
@onready var textureOxygenBar = $Player/Camera2D/CanvasLayer/TextureOxygenBar
@onready var textureHungerBar = $Player/Camera2D/CanvasLayer/TextureHungerBar
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
var waterExtractorVisited = false
var StormUnlocked = false
var inBase = false
var visitedBase = false
func _ready() -> void:
	moxie.stopMove.connect(player.stopMove)
	moxieInput.stopMove.connect(player.stopMove)
	solarPanel.stopMove.connect(player.stopMove)
	stopMove.connect(player.stopMove)
	oxygenTimer.connect(player.oxygenChange)
	hungerTimer.connect(player.hungerChange)
	$Player/Camera2D/CanvasLayer.visible = true
	$SolarPanel/ColorRect.visible = false
	$MOXIEInput/ColorRect.visible = false
	$IntroText.visible = true
	$BaseIntroText.hide()

func _on_oxygen_timer_timeout():
	if inBase:
		oxygenTimer.emit(-2)
	else:
		oxygenTimer.emit(1)

func _on_hunger_timer_timeout() -> void:
	hungerTimer.emit(1)

func _process(delta: float) -> void:
	if moxieVisited && (solarPanelVisited && (moxieInputVisited && waterExtractorVisited)):
		if not StormUnlocked:
			$Player/Camera2D/StaticBody2D/AlertTimer.start()
			StormUnlocked = true

func _on_intro_text_close_requested() -> void:
	$OxygenTimer.start()
	$HungerTimer.start()
	stopMove.emit()
	$IntroText.hide()

func _on_oxy_gen_start_storm() -> void:
	moxieVisited = true

func _on_solar_panel_start_storm() -> void:
	solarPanelVisited = true

func _on_moxie_input_start_storm() -> void:
	moxieInputVisited = true

func _on_water_extractor_start_storm() -> void:
	waterExtractorVisited = true

func _on_player_health_changed(health:int) -> void:
	print(health)
	textureHealthBar.value = health

func _on_player_energy_changed(energy:int) -> void:
	textureEnergyBar.value = energy

func _on_player_hunger_changed(hunger:int) -> void:
	textureHungerBar.value = hunger

func _on_player_oxygen_changed(oxygen:int) -> void:
	textureOxygenBar.value = oxygen

func _on_base_area_body_entered(body: Node2D) -> void:
	if not visitedBase:
		$BaseIntroText.show()
		stopMove.emit()
		visitedBase = true
	inBase = true

func _on_base_area_body_exited(body: Node2D) -> void:
	inBase = false

func _on_storm_damage_timer_timeout() -> void:
	if not inBase:
		player.healthChange(3)

func _on_static_body_2d_dust_storm() -> void:
	if $StormDamageTimer.is_stopped():
		$StormDamageTimer.start()
	else:
		$StormDamageTimer.stop()

func _on_base_intro_text_close_requested() -> void:
	$OxygenTimer.start()
	$HungerTimer.start()
	stopMove.emit()
	$BaseIntroText.hide()

func _on_base_plants_ate() -> void:
	player.hungerChange(-5)
