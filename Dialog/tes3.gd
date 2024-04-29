extends Node2D

func _physics_process(delta):
	AudioPlayer.stop()


func _on_startp_pressed():
	get_tree().change_scene_to_file("res://Dialog/kamar1.tscn")
