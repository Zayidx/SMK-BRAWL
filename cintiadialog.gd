extends CollisionShape2D

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("dialog"):
		print("dialogcintia")
		var audioosis = ResourceLoader.load("res://Backsound/cyntia nanya.mp3")
		$"../../dialogcintia".stream = audioosis
		$"../../dialogcintia".play()
		

