extends Node


func instance():
	var base = Hub.game_controller
	var world3D = Hub.world_3d
	
	print("Started")
	base.load_3d("res://Scenes/World3D/Enviornment/level_0.tscn")
	base.load_3d("res://Scenes/World3D/Entities/Player/player_last_heard_radius.tscn")
	base.load_3d("res://Scenes/World3D/Entities/Player/player_last_seen_radius.tscn")
	base.load_3d("res://Scenes/World3D/Entities/Player/player.tscn")
	base.load_3d("res://Scenes/World3D/Entities/enemy.tscn")
	base.load_gui("res://Scenes/World3D/Tasks/task_interaction.tscn")
	base.load_gui("res://Scenes/Management/settings.tscn")
	
	var enemy = world3D.get_node("Enemy")
	
	enemy.global_transform.origin = Vector3(20, 1, 30)
