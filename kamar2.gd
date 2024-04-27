extends CollisionShape2D


func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("interact"):
		print("kebuka")
		get_tree().change_scene_to_file("res://sekolahpagi.tscn")
	if event.is_action_pressed("back"):
		print("kebuka")
		get_tree().change_scene_to_file("res://kamar.tscn")
