extends CollisionShape2D


func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("dialog"):
		print("dialog osis")
		var audioosis = ResourceLoader.load("res://Backsound/scenetopi.mp3")
		$"../../scenetopi".stream = audioosis
		$"../../scenetopi".play()
