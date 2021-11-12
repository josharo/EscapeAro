extends KinematicBody

var vel: Vector3
export var speed: int = 20

var camera: Camera
var rotation_helper: Spatial
var dir: Vector3

func _ready():
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
	
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	vel.x = dir.x * speed
	vel.z = dir.z * speed
	move_and_slide(vel, Vector3.UP)
	
	print(vel)
