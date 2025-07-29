extends Control

var completed := false

func trigger():
	Hub.game_controller.gui_visible("TaskInteraction", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true


func _on_complete_task_pressed() -> void:
	completed = true
	var encrypted = randi_range(0,1) == 0
	var encryption : String
	var type : String
	var size : int
	if encrypted:
		match randi_range(0,7):
			0:
				pass
			1:
				pass
			2:
				pass
			3:
				pass
			# WORKING ON THIS - AES-2^ FOR ENCRYPTION TYPES
	
	load("res://Scenes/Other/data.tscn").instantiate()


func _on_exit_pressed() -> void:
	Hub.game_controller.gui_visible("TaskInteraction", false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
