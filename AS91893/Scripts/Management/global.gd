extends Node

var game_controller
var world_3D
var world_2d
var gui

# Game Variables
var player_noise := false


# Called when the node enters the scene tree for the first time.
func _ready():
	game_controller = load("res://Scenes/Management/game_controller.tscn").instantiate()
	print(game_controller)
	world_3D = game_controller.get_node("World3D")
	
	game_controller.get_node("startup").instance()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
