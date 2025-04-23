extends StaticBody2D
var weather = "none"
var stormInfo = false
signal dustStorm

func _process(delta: float) -> void:
	if weather == "none":
		$GPUParticles2D.emitting = false
	if weather == "dust":
		$GPUParticles2D.emitting = true

func _ready() -> void:
	$DustStormInfo.visible = false
	$GPUParticles2D.emitting = false
	$GPUParticles2D.visible = true
	$"../CanvasLayer/ColorRect".visible = false
	$CanvasModulate.visible = true

func _on_timer_timeout() -> void:
	dustStorm.emit()
	if weather == "none":
		weather = "dust"
		$StormTimer.wait_time = 10
		$StormTimer.start()
	elif weather == "dust":
		weather = "none"
		var tween = create_tween()
		tween.tween_property($CanvasModulate, "color", Color.WHITE, 3)
		$"../CanvasLayer/ColorRect".visible = false
		$StormTimer.wait_time = 5
		$AlertTimer.wait_time = 20
		$AlertTimer.start()

func _on_alert_timer_timeout() -> void:
	if weather == "none":
		if not stormInfo:
			$DustStormInfo.visible = true
		$"../CanvasLayer/ColorRect".visible = true
		if stormInfo:
			var tween = create_tween()
			tween.tween_property($CanvasModulate, "color", Color(1.0, 0.58, 0.482), 5)
			$StormTimer.wait_time = 5
			$StormTimer.start()

func _on_dust_storm_info_close_requested() -> void:
	$DustStormInfo.hide()
	var tween = create_tween()
	tween.tween_property($CanvasModulate, "color", Color(1.0, 0.58, 0.482), 5)
	$StormTimer.wait_time = 5
	$StormTimer.start()
	stormInfo = true
