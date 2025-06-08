extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

const MAX_HEALTH = 10.0
const SPEED = 1.5
const ACCELERATION = 10

var player_last_seen

func _physics_process(delta):
	var direction = Vector3()
	
	if (player_last_seen != null):
		nav_agent.target_position = player_last_seen
		
		direction = (nav_agent.get_next_path_position() - global_transform.origin).normalized() * SPEED
		
		velocity.x = direction.x
		velocity.z = direction.z
		
		move_and_slide()

func _on_timer_timeout():
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var player_position = overlap.global_transform.origin
				$VisionArea/VisionRaycast.look_at(player_position)
				$VisionArea/VisionRaycast.force_raycast_update()
				if $VisionArea/VisionRaycast.is_colliding():
					var collider = $VisionArea/VisionRaycast.get_collider()
					if collider.name == "Player":
						player_last_seen = player_position
						look_at(player_last_seen)
						$VisionArea/VisionRaycast.look_at(player_position)
						$VisionArea/VisionRaycast.rotation.x = 0
				else:
					print("Nowhere")
