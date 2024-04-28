extends Node

const scene_rumah = preload("res://rumah.tscn")
const scene_sekolahpagi = preload("res://sekolahpagi.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"rumah":
			scene_to_load = scene_rumah
		"sekolahpagi":
			scene_to_load = scene_sekolahpagi
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
