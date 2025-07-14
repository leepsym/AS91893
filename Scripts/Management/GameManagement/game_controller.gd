class_name GameController extends Node

func _ready():
	Hub.set_game_controller(self)

func gui_visible(scene: String, visible : bool) -> void:
	$GUI.get_node(scene).visible = visible

func load_3d(scene: String):
	$World3D.add_child(load(scene).instantiate())

func load_2d(scene: String):
	$World2D.add_child(load(scene).instantiate())

func load_gui(scene: String):
	$GUI.add_child(load(scene).instantiate())

func remove_3d(scene : String):
	$World3D.remove_child($Worlod3D.get_node(scene))

func remove_2d(scene : String):
	$World2D.remove_child($Worlod2D.get_node(scene))

func remove_gui(scene : String):
	$GUI.remove_child($GUI.get_node(scene))
