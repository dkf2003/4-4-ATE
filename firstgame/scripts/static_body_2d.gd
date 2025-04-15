extends StaticBody2D
var weather = "none"
signal dustStorm

func _process(delta: float) -> void:
	if weather == "none":
		self.visible = false
	if weather == "dust":
		self.visible = true

func _on_timer_timeout() -> void:
	if weather == "none":
		weather = "dust"
		$CanvasModulate.color = Color.WHITE
		var tween = create_tween()
		tween.tween_property($CanvasModulate, "color", Color(1.0, 0.58, 0.482), 3)
		dustStorm.emit()
		$Timer.wait_time = randi_range(10, 30)
		$Timer.start()
	elif weather == "dust":
		weather = "none"
		$Timer.wait_time = 60
		$Timer.start()
