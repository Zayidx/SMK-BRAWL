extends Button


@onready var main_menu = %MainMenu
@onready var settings = %Settings

func _on_pressed():
	settings.show()
	get_parent().hide()


func _on_back_pressed():
	main_menu.show()
	settings.hide()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://tes.tscn")

