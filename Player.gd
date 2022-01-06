extends KinematicBody

const GRAVITY: float = -24.8
var vel: Vector3
export var speed: int = 20
const JUMP_HEIGHT = 18

var camera: Camera
var rotation_helper: Spatial
var dir: Vector3

var detector_ray: RayCast

const MAX_SLOPE_ANGLE = deg2rad(40)
const MOUSE_SENSITIVITY = 0.05

var crateScene: PackedScene = load("res://Items/Crate.tscn")
export(PackedScene) var CrateScene: PackedScene # load or export ???

func _ready():
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
#	detector_ray = $RotationHelper/Camera/RayCast
	
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
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	
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
	
	# ------------------------------
	# TEMP: camera switch
	if Input.is_action_just_pressed("fire"):
		camera.current = not camera.current
	
	# ---------------------------------
	# TEMP: rotate
	if Input.is_action_just_pressed("reload"):
		print(transform.basis, " : ", transform.origin)
#		transform.basis = Basis(Vector3(0, 1, 0), deg2rad(45)) * transform.basis
#		transform.basis = transform.basis.rotated(Vector3(0, 1, 0), PI/4)
#		rotate(Vector3(0, 1, 0), PI)
		rotate_y(deg2rad(10))
#		rotate_object_local(Vector3(0, 1, 0), PI)
#		rotate_y(PI)
		print(transform.basis, " : ", transform.origin)
		print("\n\n")
#		print(self.rotation_degrees)
#		self.rotation_degrees = Vector3(0, 1, 0)

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	vel.y += GRAVITY * delta
	
	vel.x = dir.x * speed
	vel.z = dir.z * speed
	vel = move_and_slide(vel, Vector3.UP, false, 4, MAX_SLOPE_ANGLE)
	
const RAY_LENGTH: int = 1000
	
func _input(event):
#	if event is InputEventMouseButton:
#		print("_input")
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# event.relative.x: right(+), left(-) & event.relative.y: up(-), down(+)
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot

	# --------------------------------------------
	# 3D ray casting from screen for object picking
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var from = camera.project_ray_origin(event.position)
		var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH
		var space_state = get_world().get_direct_space_state()
		var results =  space_state.intersect_ray(from, to)
		
		var crate = crateScene.instance()

		crate.global_transform = $RotationHelper/Position3D.global_transform # on Crosshair
#		crate.global_transform = from + camera.project_ray_normal(event.position) * 50 # on mouse click
#		print($RotationHelper/Position3D.transform.origin)

		get_parent().add_child(crate) # or perhaps signal instead ???

#		if results.size() > 0:
#			for item in results:
#				print(item, " : ", results[item])
#			print("collider: ", results["collider"])

		
		if results.size() > 0: # 6 indexes. collider, collider_id, normal, position, rid, shape
			var col = results["collider"]
			print("clicked on: ", col)
			if col.name == "InteractButton":
				var owner = col.get_owner() # top parent of this collider, e.g. InteractiveItem
				look_at_object(owner.global_transform) # * Vector3(-1, 1, -1))
				
				
#				if owner.is_activated: # activated if player is close enough
#					print("Move Player to : ", $RotationHelper/Position3D.transform.origin)
#					print("Move Player to : ", $RotationHelper/Position3D.global_transform.origin)
#					self.global_transform.origin.x = owner.get_node("PlayerInteractPosition").global_transform.origin.x
#					self.global_transform.origin.z = owner.get_node("PlayerInteractPosition").global_transform.origin.z

#					look_at(owner.global_transform.origin, Vector3.UP)
#					print(owner.global_transform.origin)
					
	# --------------------------------------------
	# click on Crosshair
	if event is InputEventMouseButton and event.pressed and event.button_index == 2:
		var from = camera.project_ray_origin(event.position)
		var cross_pos: Vector2 = camera.unproject_position($RotationHelper/Camera/Crosshair.global_transform.origin)
#		print("cam pos: ", cross_pos)
		var to = from + camera.project_ray_normal(cross_pos) * RAY_LENGTH
		var space_state = get_world().get_direct_space_state()
		var results =  space_state.intersect_ray(from, to)
		
#		print(from)
#		print(to)
#		print()
		
		if results.size() > 0:
			print("collider: ", results["collider"])
		

# -------------------------
# private function
func look_at_object(target):
	print("look target: ", target, " :: Player: ", self.global_transform)
#	Transform
#	rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
#	self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

func _on_ItemDetectArea_body_entered(body):
	if body.has_method("activate_interaction"):
		body.activate_interaction()

func _on_ItemDetectArea_body_exited(body):
	if body.has_method("deactivate_interaction"):
		body.deactivate_interaction()
