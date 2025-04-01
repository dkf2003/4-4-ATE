extends CharacterBody2D

@export var speed = 150
@export var health = 100

signal healthChanged

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed * delta
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	health -= 10
	healthChanged.emit(health)
	print_debug(health)
	print_debug(area.name)

func player():
	pass
