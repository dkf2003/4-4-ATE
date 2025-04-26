extends CanvasLayer


func _ready() -> void:
	if GlobalVars.timeStart == 0:
		$RichTextLabel2.text = "You survived for: 0 seconds"
	else:
		var surviveTime : float = float(GlobalVars.timeEnd - GlobalVars.timeStart)/1000
		$RichTextLabel2.text = "You survived for: %s seconds" % surviveTime

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
