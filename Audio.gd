extends TabBar



func _on_master_value_changed(value):
	set_volume(0,value)


func _on_music_value_changed(value):
	set_volume(2,value)


func _on_sfx_value_changed(value):
	set_volume(3,value)
	
func set_volume(idx,value):
	AudioServer.set_bus_volume_db(idx,linear_to_db(value))
