extends Node2D
@onready var timer = $GrowthTimer
@onready var sprite = $Area2D/AnimatedSprite2D
@onready var keyPrompt = $KeyPrompt
var player_in_area = false
var harvestable = false
signal ate
func _ready():
	self.visible = true
	keyPrompt.visible = false
	sprite.frame = 0
	timer.wait_time = randi_range(2,5)
	timer.start()

func _on_growth_timer_timeout() -> void:
	if sprite.frame < 15:
		sprite.frame += 1
	else:
		harvestable = true
	timer.wait_time = randi_range(2,5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func _process(delta: float) -> void:
	if harvestable:
		keyPrompt.visible = true
		if Input.is_action_just_pressed("e") and player_in_area:
			ate.emit()
			sprite.frame = 0
			harvestable = false
	else:
		keyPrompt.visible = false
