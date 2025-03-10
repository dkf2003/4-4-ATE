extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Im a Mars plant")
	queue_free()
