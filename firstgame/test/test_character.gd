extends GutTest

var Player = preload("res://scripts/player.gd")
var player : Player

func before_each() -> void:
	player = Player.new()
	add_child(player)
	await get_tree().process_frame
	
func after_each() -> void:
	player.queue_free()

func test_initial_hunger() -> void:
	assert_eq(player.hunger, 100, "Player should start with 100 hunger")
	
func test_movement_speed() -> void:
	assert_eq(player.speed, 150, "Player should start with 150 speed")

func test_initial_health() -> void:
	assert_eq(player.health, 100, "Player should start with 100 health")
	
func test_initial_energy() -> void:
	assert_eq(player.energy, 100, "Player should start with 100 energy")

func test_initial_oxygen() -> void:
	assert_eq(player.oxygenLevel, 100, "Player should start with 100 oxygen")
	
func test_oxygen_increment() -> void:
	player.oxygenChange(1)
	assert_eq(player.oxygenLevel, 99, "Player should lose 1 oxygen")
