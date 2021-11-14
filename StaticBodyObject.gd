extends StaticBody

func _ready():
	connect("input_event", self, "_on_StaticBodyObject_mouse_clicked")

func _on_StaticBodyObject_mouse_clicked(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
#		if event.is_action_pressed()
		print(self.name, event.button_index)

