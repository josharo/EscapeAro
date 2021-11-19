extends StaticBody
class_name InteractiveItem

var is_detected: bool = false
# --------------------------
# Touch/Click object picking with CollisionObject method
# It picks everything visible on screen regardless the distance
#func _input_event(camera, event, position, normal, shape_idx):
#	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
#		print(self.name, event.button_index)




#var in_animation:bool = false
#
#func _ready():
#	$AnimatedSprite.animation = "default"
#	$AnimatedSprite.frame = 0
#func _input_event(camera, event, position, normal, shape_idx):
#	pass
#func _input_event(viewport, event, shape_idx):
#	if event is InputEventScreenTouch:
#		if in_animation:
#			return
#		if event.pressed:
#			play_animation()
#			in_animation = true
#		else: # touch released
#			pass
#
#func play_animation():
#	$AnimatedSprite.play("default") # default animation

#func _on_DetectedArea_body_entered(body):
#	if body.name == 'Player':
#		$ActivateButton.set_visible(true)
#		is_detected = true
#	print(body.name, " entered.", " : ", is_detected)
#
#
#func _on_DetectedArea_body_exited(body):
#	if body.name == 'Player':
#		$ActivateButton.set_visible(false)
#		is_detected = false
#	print(body.name, " exited.", " : ", is_detected)

# --------------------------------------------
# show/hide the interacte button
# used by Player
func show_interact_button():
	$InteractButton.set_visible(true)
func hide_interact_button():
	$InteractButton.set_visible(false)



func _on_ActivateButton_input_event(camera, event, position, normal, shape_idx):
#	print("active zzzzz")
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
#		var from = camera.project_ray_origin(event.position)
#		var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH
#
#		var space_state = get_world().get_direct_space_state()
#		var results =  space_state.intersect_ray(from, to)
#
#		var crate = crateScene.instance()
#		get_parent().add_child(crate) # or perhaps signal instead ???
#
#		if results.size() > 0:
#			for item in results:
#				print(item, " : ", results[item])
#			print("\n\n")
		print("Let's do this....")



func _on_InteractButton_mouse_entered():
	print(self, " entered")


func _on_InteractButton_mouse_exited():
	print(self, " EXITED")
