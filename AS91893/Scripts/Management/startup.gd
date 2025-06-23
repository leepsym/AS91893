extends Node


func instance():
	var base = Hub.game_controller
	var world3D = Hub.world_3D
	
	base.change_3d_scene("res://Scenes/World3D/Enviornment/level_0.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Entities/Player/player.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Entities/enemy.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Entities/enemy.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Entities/Player/player_last_heard_radius.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Entities/Player/player_last_seen_radius.tscn", false, true)
	base.change_3d_scene("res://Scenes/World3D/Tasks/task_access_point.tscn", false, true)
	
	var enemy = world3D.get_node("Enemy")
	var taskPoint = world3D.get_node("TaskAccessPoint")
	
	enemy.global_transform.origin = Vector3(20, 1, 30)
	taskPoint.global_transform.origin = Vector3(-10, 0, 30.5)
	taskPoint.rotation.y = 90
