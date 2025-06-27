extends Node

var game_controller
var world_3d
var world_2d
var gui

# Game Variables
var player_noise := false


func set_game_controller(node: Node):
	game_controller = node
	world_3d = game_controller.get_node("World3D")
	world_2d = game_controller.get_node("World2D")
	gui = game_controller.get_node("GUI")
	
	game_controller.get_node("startup").instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
