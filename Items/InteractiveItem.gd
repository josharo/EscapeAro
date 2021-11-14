extends Area

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
#		if event.is_action_pressed()
		print(self.name, event.button_index)

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
