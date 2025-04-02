extends CharacterBody2D

@export var speed = 150
@export var health = 100
@export var oxygenLevel = 100
@export var hunger = 100
@export var energy = 100

signal healthChanged
signal energyChanged
signal oxygenChanged
signal hungerChanged

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position += Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed * delta
	#print_debug(position)
	#energy -= 1
	#energyChanged.emit(energy)
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	health -= 10
	healthChanged.emit(health)
	print_debug(health)
	print_debug(area.name)
	
func oxygenChange(change: int):
	oxygenLevel -= change
	if oxygenLevel < 0:
		oxygenLevel = 0
		health -= 5
		healthChanged.emit(health)
	else:
		oxygenChanged.emit(oxygenLevel)
	

func hungerChange(change: int):
	hunger -= change
	if hunger < 0:
		hunger = 0
		health -= 5
		healthChanged.emit(health)
	else:
		hungerChanged.emit(hunger)

func player():
	pass
