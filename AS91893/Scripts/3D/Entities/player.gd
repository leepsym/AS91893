extends CharacterBody3D

# Camera Imports
@onready var head = $MeshInstance3D/SwivelHead
@onready var camera = $MeshInstance3D/SwivelHead/Camera3D
@onready var standingHitbox = $StandingHitbox
@onready var crouchingHitbox = $CrouchingHitbox
@onready var headBumpChecker = $RayCast3D

# Movement
var current_speed = 5.0
var walking_speed = 5.0
var crouching_speed = 3.0
var crouching_depth = -0.45
var sprinting_speed = 8.0
var lerp_speed = 10.0
var direction = Vector3.ZERO

# User controlled variables
var mouse_sens = 0.375

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
	elif !headBumpChecker.is_colliding():
		crouchingHitbox.disabled = true
		standingHitbox.disabled = false
		head.position.y = lerp(head.position.y, 0.8, delta * lerp_speed)
		if Input.is_action_pressed("moveSprint"):
			current_speed = sprinting_speed
		else:
			current_speed = walking_speed
	
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
