extends StaticBody

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


func _on_DetectedArea_body_entered(body):
	if body.name == 'Player':
		is_detected = true
	print(body.name, " entered.", " : ", is_detected)


func _on_DetectedArea_body_exited(body):
	if body.name == 'Player':
		is_detected = false
	print(body.name, " exited.", " : ", is_detected)
