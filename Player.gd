class_name PlayerEntity
extends CharacterBody2D

@export var speed = 400
@export var gravity = 30
@export var jump_force = 600
@onready var anim = get_node("AnimatedSprite")
var hp = 100

func _physics_process(_delta):
	print($Player/CollisionShape2D2.disabled)
	velocity.x = 0
	if hp <= 0:
		queue_free()
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1500:
			velocity.y = 500
			
	if Input.is_action_just_pressed("jump") && is_on_floor() && !is_attacking():
		velocity.y = -jump_force
	elif Input.is_action_pressed("move_left") && !is_attacking():	
		anim.play("Run")
		anim.flip_h = true
		velocity.x = -speed
	elif Input.is_action_pressed("move_right") && !is_attacking():
		anim.play("Run")
		velocity.x = speed
		anim.flip_h = false
		
	
	elif is_on_floor() :
		if(!is_attacking()):
			anim.play("idle")
	if Input.is_action_just_pressed("attack"):
		anim.play("attack")
		$Player/CollisionShape2D2.disabled = false
	if !is_attacking():
		$Player/CollisionShape2D2.disabled = true
		
	if velocity.y <0:
		anim.play("jump")
	if velocity.y >0:
		anim.play("turun")

	
	
	
	move_and_slide()



func _on_area_2d_body_entered(body):
	print("Terkena object")
	if body.is_in_group("Enemy"):
		body.queue_free()


func is_attacking():
	if anim.animation == "attack" && anim.frame < 1:
		return true
	else: 
		return false


func _on_Player_body_entered(body):
	if body.is_in_group("enemy"):
		body._take_damage(20)

func take_damage(damage):
	hp -= damage
