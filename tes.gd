extends Node2D

func _ready():
	AudioPlayer1.play_music_level()

func _on_startp_pressed():
	get_tree().change_scene_to_file("res://kamar.tscn")
