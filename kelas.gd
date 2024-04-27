extends Area2D


func _input(event):
	if event.is_action_pressed("back"):
		print("kebuka")
		get_tree().change_scene_to_file("res://Map.tscn")
