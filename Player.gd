extends KinematicBody

const GRAVITY: float = -24.8
var vel: Vector3
export var speed: int = 20
const JUMP_HEIGHT: int = 108

var camera: Camera
var rotation_helper: Spatial
var dir: Vector3

const MAX_SLOPE_ANGLE = deg2rad(40)

func _ready():
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	
	var input_movement_vector: Vector2 = Vector2()
	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	
	input_movement_vector = input_movement_vector.normalized()
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	
	# --------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_HEIGHT
	
	# --------------------------
	# Mouse cursor capture/release
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	vel.y += GRAVITY * delta
	
	vel.x = dir.x * speed
	vel.z = dir.z * speed
	vel = move_and_slide(vel, Vector3.UP, false, 4, MAX_SLOPE_ANGLE)
	
	print(vel)
