extends Spatial

var player
var target

func _ready():
	player = $Player
	target = $Crate

func _process(delta):
	if Input.is_action_pressed("flashlight"):
		player.look_at(target.global_transform.origin, Vector3.UP)

