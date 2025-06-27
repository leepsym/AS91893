extends CharacterBody3D

@onready var nav_agent = $NavigationAgent
@onready var vision_raycast = $VisionArea/VisionRaycast


# Containers
@onready var environment = get_parent().get_node("Environment")
@onready var nav_region = environment.get_node("NavigationRegion3D")
@onready var traverse_nodes = nav_region.get_node("EnemyTraverseNodes")

# Nodes
@onready var player_node = get_parent().get_node("PlayerLastSeenRadius")
@onready var player_heard_range = get_parent().get_node("PlayerLastHeardRadius")

@onready var current_node = traverse_nodes.get_child(rnd.randi_range(0, traverse_nodes.get_child_count() - 1))


var rnd = RandomNumberGenerator.new()


const MAX_HEALTH = 10.0
const SPEED = 4
const CHASE_SPEED = 7
const ACCELERATION = 10

var player_last_seen : Vector3
var player_seen = false

func _ready():
	nav_agent.target_position = current_node.global_transform.origin # Set pathfinding to first node

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
						player_seen = true
				else:
					player_seen = false
					nav_agent.target_position = player_last_seen
					look_at(global_transform.origin + velocity)
			else:
				traverse()
	else:
		traverse()
	
	hearing()
	
	# Moving
	var direction = Vector3()
	
	if player_last_seen != null:
		if player_seen:
			direction = (nav_agent.get_next_path_position() - global_transform.origin).normalized() * CHASE_SPEED
		else:
			direction = (nav_agent.get_next_path_position() - global_transform.origin).normalized() * SPEED
	
		
		velocity = velocity.lerp(direction, delta * 10)
		velocity.y = 0
		
		move_and_slide()
	


func traverse():
	look_at(global_transform.origin + velocity)
	
	if (player_seen):
		if (player_node.global_transform.origin != player_last_seen): 
			player_node.global_transform.origin = player_last_seen
			current_node = player_node
	
	var overlaps = current_node.get_overlapping_bodies()
	for overlap in overlaps:
		if overlap == self:
			current_node = traverse_nodes.get_child(rnd.randi_range(0, traverse_nodes.get_child_count() - 1))
			nav_agent.target_position = current_node.global_transform.origin


func hearing():
	var hearing_overlaps = $HearingArea.get_overlapping_bodies()
	for overlap in hearing_overlaps:
		if overlap.name == "Player" && Hub.player_noise:
			if (player_heard_range.global_transform.origin != player_last_seen): 
				player_heard_range.global_transform.origin = player_last_seen
				var nearby_nodes = player_heard_range.get_overlapping_areas()
				
				if nearby_nodes.size() > 0:
					current_node = nearby_nodes[rnd.randi_range(0, nearby_nodes.size())]
				elif (player_node.global_transform.origin != player_last_seen): 
						player_node.global_transform.origin = player_last_seen
						current_node = player_node
			
			nav_agent.target_position = current_node.global_transform.origin
	
	var close_hearing_overlaps = $HearingArea/CloseHearingArea.get_overlapping_bodies()
	for overlap in close_hearing_overlaps:
		if overlap.name== "Player" && Hub.player_noise:
			player_last_seen = overlap.global_transform.origin
			
			if (player_node.global_transform.origin != player_last_seen): 
				player_node.global_transform.origin = player_last_seen
				current_node = player_node
			
			nav_agent.target_position = current_node.global_transform.origin
