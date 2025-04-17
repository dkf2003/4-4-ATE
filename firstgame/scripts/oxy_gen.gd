extends Node2D
var player_in_area = false
signal stopMove
signal startStorm
signal stopTimer
#func _on_body_entered(body: Node2D) -> void:
	#print("'E' Collect")

func _process(delta: float) -> void:
	if player_in_area:
		$KeyPrompt.show()
		if Input.is_action_just_pressed("e"):
			$"../OxygenTimer".stop()
			$"../HungerTimer".stop()
			$Window.show()
			stopMove.emit()
	else:
		$KeyPrompt.hide()

func _on_window_close_requested() -> void:
	$Window.hide()
	$"../OxygenTimer".start()
	$"../HungerTimer".start()
	stopMove.emit()
	startStorm.emit()


#func _on_pickable_area_body_entered(body: Node2D) -> void:
	#print("Player in")
	#if body.has_method("player"):
		#player_in_area = true
#
#
#func _on_pickable_area_body_exited(body: Node2D) -> void:
	#print("Player left")
	#if body.has_method("player"):
		#player_in_area = false


func _on_oxygen_generator_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true


func _on_oxygen_generator_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
