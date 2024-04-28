extends Node2D

func _input(event):
	if event.is_action_pressed("interact"):
		print("kebuka")
		get_tree().change_scene_to_file("res://rumah.tscn")


func _on_startp_pressed():
	get_tree().change_scene_to_file("res://rumah.tscn")
