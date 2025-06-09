extends CharacterBody3D

@onready var nav_agent = $NavigationAgent
@onready var vision_raycast = $VisionArea/VisionRaycast
@export var base_envorionment : Node3D
@onready var traverse_nodes = base_envorionment.get_node("NavigationRegion3D/EnemyTraverseNodes")


var rnd = RandomNumberGenerator.new()


const MAX_HEALTH = 10.0
const SPEED = 1.5
const ACCELERATION = 10

var player_last_seen

func _on_ready():
	nav_agent.target_position = traverse_nodes.get_child(rnd.randi_range(0, 9))

func _physics_process(delta):
	# Chasing player if seen
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var player_position = overlap.global_transform.origin
				vision_raycast.look_at(player_position)
				vision_raycast.force_raycast_update()
				if vision_raycast.is_colliding():
					var collider = vision_raycast.get_collider()
					if collider.name == "Player":
						player_last_seen = player_position
						look_at(player_last_seen)
						vision_raycast.look_at(player_position)
						nav_agent.target_position = player_last_seen
				else:
					nav_agent.target_position = player_last_seen
					look_at(global_transform.origin + velocity)
			else:
				traverse()
	else:
		traverse()
	
	
	# Moving
	var direction = Vector3()
	
	if (player_last_seen != null):
		
		direction = (nav_agent.get_next_path_position() - global_transform.origin).normalized() * SPEED
		
		velocity = velocity.lerp(direction, delta * 10)
		velocity.y = 0
		
		move_and_slide()
	

func traverse():
	look_at(global_transform.origin + velocity)
	print(velocity)
	if (global_transform.origin >= nav_agent.get_next_path_position()):
		nav_agent.target_position = traverse_nodes.get_child(rnd.randi_range(0, 9)).global_transform.origin
