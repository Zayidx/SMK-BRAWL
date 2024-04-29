extends Node2D

func _ready():
	AudioPlayer1.play_music_level()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Dialog/kamar2.tscn")
