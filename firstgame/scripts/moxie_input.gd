extends Node2D
var player_in_area = false
var visited = false
signal stopMove
signal startStorm

func _process(delta: float) -> void:
	if player_in_area:
		$KeyPrompt.show()
		if Input.is_action_just_pressed("e"):
			$Window.show()
			$"../OxygenTimer".stop()
			$"../HungerTimer".stop()
			stopMove.emit()
	else:
		$KeyPrompt.hide()

func _on_window_close_requested() -> void:
	$Window.hide()
	$"../OxygenTimer".start()
	$"../HungerTimer".start()
	stopMove.emit()
	startStorm.emit()

func _on_input_area_body_entered(body: Node2D) -> void:
	print("Player in")
	if body.has_method("player"):
		player_in_area = true

func _on_input_area_body_exited(body: Node2D) -> void:
	print("Player out")
	if body.has_method("player"):
		player_in_area = false
