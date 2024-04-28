extends CharacterBody2D


@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")
	anim.flip_h = true


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Dialog/kelas4.tscn")
