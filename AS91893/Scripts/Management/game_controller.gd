class_name GameController extends Node

@onready var world_3d = $World3D
@onready var world_2d = $World2D
@onready var gui = $GUI

var current_3d_scene
var current_2d_scene
var current_gui_scene


func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() # Removes node entirely
		elif keep_running:
			current_gui_scene.visible = false # Keeps in memory and running
		else:
			gui.remove_child(current_gui_scene) # Keeps in memory, does not run
	
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free() # Removes node entirely
		elif keep_running:
			current_2d_scene.visible = false # Keeps in memory and running
		else:
			world_2d.remove_child(current_2d_scene) # Keeps in memory, does not run
	
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new

func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free() # Removes node entirely
		elif keep_running:
			current_3d_scene.visible = false # Keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene) # Keeps in memory, does not run
	
	var new = load(new_scene).instantiate()
	world_3d.add_child(new)
	current_3d_scene = new
