extends Control
func _on_play_pressed():
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_options_pressed():
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://scenes/optionsmenuworld.tscn")

func _on_quit_pressed():
	pass # Replace with function body.
	get_tree().quit()


func _on_volume_pressed():
	pass # Replace with function body.



func _on_back_pressed():
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://scenes/world.tscn")
