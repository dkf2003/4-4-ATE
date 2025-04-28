extends Node2D

@onready var sfx_interact: AudioStreamPlayer2D = $sfx_interact

@onready var solarPanel = $"../SolarPanel"
@onready var moxieInput = $"../MOXIEInput"
@onready var waterExtractor = $"../WaterExtractor"
var player_in_area = false
signal stopMove
var solarPanelString = "[b][color=yellow]Solar Panel[/color][/b]: "
var moxieString = "[b][color=blue]MOXIE System[/color][/b]: "
var waterString = "[b][color=aqua]Water Extractor[/color][/b]: "
var plantString = "[b][color=limegreen]Plant System[/color][/b]: "
var spacing = "



"
func _ready() -> void:
	$KeyPrompt.hide()
	$ConsoleText.hide()

func _process(delta: float) -> void:
	if player_in_area:
		if Input.is_action_just_pressed("e"):
			sfx_interact.play()
			$ConsoleText.show()
			$"../OxygenTimer".stop()
			$"../HungerTimer".stop()
			stopMove.emit()
	if not solarPanel.isFunctional:
		solarPanelString = "[b][color=yellow]Solar Panel[/color][/b]: [color=red]Non-Operational: Covered in Mars dust[/color]"
		moxieString = "[b][color=blue]MOXIE System[/color][/b]: [color=red]Non-Operational: No power"
		waterString = "[b][color=aqua]Water Extractor[/color][/b]: [color=red]Non-Operational: No power"
		plantString = "[b][color=limegreen]Plant System[/color][/b]: [color=red]Non-Operational: No power, No water"
		if not moxieInput.isFunctional:
			moxieString += ", Covered in Mars dust"
		if not waterExtractor.isFunctional:
			waterString += ", Covered in Mars dust"
	elif not moxieInput.isFunctional or not waterExtractor.isFunctional:
		solarPanelString = "[b][color=yellow]Solar Panel[/color][/b]: [color=green]Operational[/color]"
		if not moxieInput.isFunctional:
			moxieString = "[b][color=blue]MOXIE System[/color][/b]: [color=red]Non-Operational: Covered in Mars dust"
		else:
			moxieString = "[b][color=blue]MOXIE System[/color][/b]: [color=green]Operational[/color]"
		if not waterExtractor.isFunctional:
			waterString = "[b][color=aqua]Water Extractor[/color][/b]: [color=red]Non-Operational: Covered in Mars dust"
			plantString = "[b][color=limegreen]Plant System[/color][/b]: [color=red]Non-Operational: No water"
		else:
			waterString = "[b][color=aqua]Water Extractor[/color][/b]: [color=green]Operational[/color]"
			plantString = "[b][color=limegreen]Plant System[/color][/b]: [color=green]Operational[/color]"
	else:
		solarPanelString = "[b][color=yellow]Solar Panel[/color][/b]: [color=green]Operational[/color]"
		moxieString = "[b][color=blue]MOXIE System[/color][/b]: [color=green]Operational[/color]"
		waterString = "[b][color=aqua]Water Extractor[/color][/b]: [color=green]Operational[/color]"
		plantString = "[b][color=limegreen]Plant System[/color][/b]: [color=green]Operational[/color]"
	$ConsoleText/RichTextLabel.text = solarPanelString + spacing + moxieString + spacing + waterString + spacing + plantString


func _on_console_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		$KeyPrompt.show()

func _on_console_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		$KeyPrompt.hide()

func _on_console_text_close_requested() -> void:
	$"../OxygenTimer".start()
	$"../HungerTimer".start()
	stopMove.emit()
	$ConsoleText.hide()
