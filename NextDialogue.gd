extends Button

var dialogue : Dialogue:
	set(value):
		dialogue = value
		text = dialogue.path_option


func _on_pressed():
	if dialogue.options.size() == 0:
		return
		Sekolahpagi.dialogue = dialogue
