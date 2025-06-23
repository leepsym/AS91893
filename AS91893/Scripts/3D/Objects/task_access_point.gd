extends Node3D

@onready var player = Hub.game_controller.get_node("World3D").get_node("Entities").get_node("Player")

func _process(delta):
	var overlaps = $PlayerAccessArea.get_overlapping_bodies()
	for overlap in overlaps:
		if overlap == player && Input.is_action_just_pressed("interact"):
			pass
