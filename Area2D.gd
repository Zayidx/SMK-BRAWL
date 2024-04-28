extends Area2D

func _on_startp_pressed():
	print("kebuka")
	get_tree().change_scene_to_file("res://rumah.tscn")
