extends Area2D
var player_in_area

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
