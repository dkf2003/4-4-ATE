extends Area2D
var visited = false
signal stopMove

func _ready() -> void:
	$"../PlantInfoText".hide()

func _on_body_entered(body: Node2D) -> void:
	print("player in")
	if not visited and body.has_method("player"):
		$"../PlantInfoText".show()
		stopMove.emit()
		visited = true

func _on_plant_info_text_close_requested() -> void:
	$"../PlantInfoText".hide()
	stopMove.emit()
