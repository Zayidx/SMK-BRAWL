extends Area2D

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("interact"):
		print("kebuka")
		get_tree().change_scene_to_file("res://rumah.tscn")

