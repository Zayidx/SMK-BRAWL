extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")





func _on_button_pressed():
		get_tree().change_scene_to_file("res://Dialog/sekolahpagi1.tscn")
