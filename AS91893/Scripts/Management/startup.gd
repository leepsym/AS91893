extends Node


func instance():
	var base = Hub.game_controller
	var world3D = Hub.world_3d
	
	print("Started")
	base.load_3d_scene("res://Scenes/World3D/Enviornment/level_0.tscn")
	base.load_3d_scene("res://Scenes/World3D/Entities/Player/player.tscn")
	base.load_3d_scene("res://Scenes/World3D/Entities/enemy.tscn")
	base.load_3d_scene("res://Scenes/World3D/Entities/enemy.tscn")
	base.load_3d_scene("res://Scenes/World3D/Entities/Player/player_last_heard_radius.tscn")
	base.load_3d_scene("res://Scenes/World3D/Entities/Player/player_last_seen_radius.tscn")
	base.load_3d_scene("res://Scenes/World3D/Tasks/task_access_point.tscn")
	
	var enemy = world3D.get_node("Enemy")
	var taskPoint = world3D.get_node("TaskAccessPoint")
	
	enemy.global_transform.origin = Vector3(20, 1, 30)
	taskPoint.global_transform.origin = Vector3(-10, 0, 30.5)
	taskPoint.rotation.y = 90
