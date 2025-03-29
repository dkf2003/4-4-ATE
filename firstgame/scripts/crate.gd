extends Node2D

var player_in_area = false

#func _on_body_entered(body: Node2D) -> void:
	#print("'E' Collect")

func _process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			print("+1 Crate")
			queue_free()


func _on_pickable_area_body_entered(body: Node2D) -> void:
	print("Player in")
	if body.has_method("player"):
		player_in_area = true


func _on_pickable_area_body_exited(body: Node2D) -> void:
	print("Player left")
	if body.has_method("player"):
		player_in_area = false
