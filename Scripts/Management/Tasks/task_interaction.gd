extends Control

func trigger():
	Hub.game_controller.gui_visible("TaskInteraction", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_button_pressed() -> void:
	pass


func _on_button_2_pressed() -> void:
	pass


func _on_button_3_pressed() -> void:
	pass


func _on_button_4_pressed() -> void:
	Hub.game_controller.gui_visible("TaskInteraction", false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
