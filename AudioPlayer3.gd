extends AudioStreamPlayer


const level_music = preload("res://Backsound/Night ambience  Sound Effect  Free Music Royalty.mp3")

func _play_music(music: AudioStream, volume = -2.0):
	if stream == music:
		return
		
	stream = music
	volume_db = volume
	play()

func play_music_level():
	_play_music(level_music)
