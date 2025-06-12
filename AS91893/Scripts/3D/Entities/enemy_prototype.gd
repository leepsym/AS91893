extends CharacterBody3D


@export var base_environment : Node3D

@onready var nav_agent = $NavigationAgent
@onready var vision_raycast = $VisionArea/VisionRaycast
@onready var navigation_region = base_environment.get_node("NavigationRegion3D")
@onready var traverse_nodes = navigation_region.get_node("EnemyTraverseNodes")
@onready var player_node = navigation_region.get_node("PlayerLastSeenRadius")

@onready var current_node = traverse_nodes.get_child(0)


var rnd = RandomNumberGenerator.new()


const MAX_HEALTH = 10.0
const SPEED = 1.5
const ACCELERATION = 10

var player_last_seen : Vector3

func _ready():
	current_node = traverse_nodes.get_child(rnd.randi_range(0, 9))
	nav_agent.target_position = current_node.global_transform.origin

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
	
	if (player_last_seen == nav_agent.target_position):
		if (player_node.global_transform.origin != player_last_seen): 
			player_node.global_transform.origin = player_last_seen
			current_node = player_node
	
	var overlaps = current_node.get_overlapping_bodies()
	for overlap in overlaps:
		print(overlap)
		if overlap == self:
			current_node = traverse_nodes.get_child(rnd.randi_range(0, 9))
			nav_agent.target_position = current_node.global_transform.origin
