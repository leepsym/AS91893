extends CharacterBody3D

# Camera Imports
@onready var head = $MeshInstance3D/SwivelHead
@onready var camera = $MeshInstance3D/SwivelHead/Camera3D
@onready var standingHitbox = $StandingHitbox
@onready var crouchingHitbox = $CrouchingHitbox
@onready var headBumpChecker = $RayCast3D

# Statistics
var health = 30
var damage = 15
var speed = 4

var inventory : Array[Data]

# Movement
var current_speed = 0
var walking_speed = speed
var crouching_speed = speed / 2
var crouching_depth = -0.45
var sprinting_speed = speed + 2
var lerp_speed = 10.0
var direction = Vector3.ZERO


# User controlled variables
var mouse_sens = 0.37

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotation.x = clamp(head.rotation.x + deg_to_rad(-event.relative.y * mouse_sens), deg_to_rad(-69), deg_to_rad(69))

func _physics_process(delta):
	if Input.is_action_pressed("moveCrouch"):
		current_speed = crouching_speed
		head.position.y = lerp(head.position.y, 0.8 + crouching_depth, delta * lerp_speed)
		standingHitbox.disabled = true
		crouchingHitbox.disabled = false
		Hub.player_noise = false
	elif !headBumpChecker.is_colliding():
		crouchingHitbox.disabled = true
		standingHitbox.disabled = false
		head.position.y = lerp(head.position.y, 0.8, delta * lerp_speed)
		if Input.is_action_pressed("moveSprint"):
			current_speed = sprinting_speed
		else:
			current_speed = walking_speed
		if !(velocity.x > -0.3 && velocity.x < 0.3) or !(velocity.z > -0.3 && velocity.z < 0.3):
			Hub.player_noise = true
		elif (velocity.x > -0.3 && velocity.x < 0.3) && (velocity.z > -0.3 && velocity.z < 0.3):
			Hub.player_noise = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("moveRight", "moveLeft", "moveBack", "moveForward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_speed)
	 
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()

func _hit(damage:int):
	health -= damage
	
	if health > 0:
		camera.get_node("AnimationPlayer").play("player_hit")
	else:
		Hub.game_controller.load_gui("res://Scenes/GUI/death_screen.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
