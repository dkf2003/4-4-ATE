extends Node2D
var player_in_area = false
var isFunctional = true
var visited = false
signal stopMove
signal startStorm
#func _on_body_entered(body: Node2D) -> void:
	#print("'E' Collect")

func _process(delta: float) -> void:
	if player_in_area:
		if not visited:
			$KeyPrompt.show()
		if Input.is_action_just_pressed("e"):
			if not visited:
				$"../OxygenTimer".stop()
				$"../HungerTimer".stop()
				$Window.show()
				$KeyPrompt.hide()
				stopMove.emit()
			elif not isFunctional:
				$ColorRect.visible = true
				isFunctional = true
	elif isFunctional:
		$Window.hide()
		$KeyPrompt.hide()
	elif not isFunctional:
		$KeyPrompt.show()

func _on_window_close_requested() -> void:
	$Window.hide()
	$"../OxygenTimer".start()
	$"../HungerTimer".start()
	stopMove.emit()
	startStorm.emit()
	visited = true

func _on_solar_panel_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_solar_panel_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		$ColorRect.visible = false
		player_in_area = false

func _on_static_body_2d_dust_storm() -> void:
	isFunctional = false
