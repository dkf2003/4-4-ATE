class_name Player extends CharacterBody2D

@export var speed = 150
@export var health = 100
@export var oxygenLevel = 100
@export var hunger = 100
@export var energy = 100
var canMove = false

signal healthChanged
signal energyChanged
signal oxygenChanged
signal hungerChanged

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if canMove:
		position += Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed * delta
		move_and_slide()

func stopMove():
	canMove = not canMove

func healthChange(change: int):
	health -= change
	if health < 0:
		health = 0
		GlobalVars.timeEnd = Time.get_ticks_msec()
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
	healthChanged.emit(health)

func oxygenChange(change: int):
	oxygenLevel -= change
	if oxygenLevel < 0:
		oxygenLevel = 0
		healthChange(5)
		oxygenChanged.emit(oxygenLevel)
	elif oxygenLevel > 100:
		oxygenLevel = 100
		oxygenChanged.emit(oxygenLevel)
	else:
		oxygenChanged.emit(oxygenLevel)

func hungerChange(change: int):
	hunger -= change
	if hunger < 0:
		hunger = 0
		healthChange(5)
		hungerChanged.emit(hunger)
	elif hunger > 100:
		hunger = 100
		hungerChanged.emit(hunger)
	else:
		hungerChanged.emit(hunger)

func heal():
	if oxygenLevel > 90 && hunger > 90:
		healthChange(-1)

func player():
	pass
