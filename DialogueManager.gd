extends Node

@export var next_button : PackedScene

var dialogue : Dialogue:
	set(value):
		dialogue = value
		
		%Icon.texture = value.texture
		%Name.text = value.mame
		%Dialogue.text = value.dialogue
		
		reset_options()
		add_buttons(value.options)
 
		await get_tree().create_timer(0.5).timeout
		%Options.show()

#test
func _ready():
	dialogue = load("res://NPCs/Catman/Dialogues/0.tres")
	
func reset_options():
	for child in %Options.get_children():
		child.queue_free()
	%Options.hide()
	
func add_buttons(options):
	for option in options:
		var button = next_button.instantiate()
		button.dialogue = option
		%Options.add_child(button)
