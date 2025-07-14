extends Control

func _process(float) -> void:
	if (Input.is_action_just_pressed("esc")):
		trigger()

func trigger():
	Hub.game_controller.gui_visible("Settings/CenterContainer/MainMenu", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_resume_pressed() -> void:
	Hub.game_controller.gui_visible("Settings", false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	
func _on_return_pressed() -> void:
	get_node("CenterContainer/SettingsMainMenu").visible = false
	get_node("CenterContainer/ControlsMenu").visible = false
	get_node("CenterContainer/MainMenu").visible = true



func _on_settings_pressed() -> void:
	get_node("CenterContainer/MainMenu").visible = false
	get_node("CenterContainer/SettingsMainMenu").visible = true

func _on_controls_pressed() -> void:
	get_node("CenterContainer/SettingsMainMenu").visible = false
	get_node("CenterContainer/ControlsMenu").visible = true

func _on_sensitivity_slider_value_changed(value: float) -> void:
	get_node("CenterContainer/ControlsMenu/VBoxContainer/MouseSensitivityValue").text = value
	get_node("../../World3D/Player").mouse_sens = value
