extends Node2D


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	AudioPlayer1.stop()

func _ready():
	AudioPlayer2.play_music_level()
