extends Node2D
var player_in_area = false
var visited = false
var isFunctional = true
signal stopMove
signal startStorm

func _process(delta: float) -> void:
	if player_in_area:
		$KeyPrompt.show()
		if Input.is_action_just_pressed("e"):
			if not visited:
				$"../OxygenTimer".stop()
				$"../HungerTimer".stop()
				$Window.show()
				stopMove.emit()
			else:
				$ColorRect.show()
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

func _on_input_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_input_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		$ColorRect.hide()
		player_in_area = false

func _on_static_body_2d_dust_storm() -> void:
	isFunctional = false
