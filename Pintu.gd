extends Area2D

var target_scene : String = "res:/" # Ganti dengan path ke scene yang diinginkan

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("interact"):
		open_door()

func open_door():
	get_tree().change_scene(target_scene)
