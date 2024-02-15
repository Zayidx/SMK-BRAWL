extends CharacterBody2D

@export var speed = 400
@export var gravity = 30
@export var jump_force = 600
@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta):
	print($Player/CollisionShape2D2.disabled)
	velocity.x = 0
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1500:
			velocity.y = 500
			
	if Input.is_action_just_pressed("jump") && is_on_floor() && !is_attacking():
		velocity.y = -jump_force
		anim.play("jump")
	elif Input.is_action_pressed("move_left") && !is_attacking():
		anim.play("run")
		anim.flip_h = true
		velocity.x = -speed
	elif Input.is_action_pressed("move_right") && !is_attacking():
		anim.play("run")
		velocity.x = speed
		anim.flip_h = false
		
	elif is_on_floor() :
		if(!is_attacking()):
			anim.play("idle")
	if Input.is_action_just_pressed("attack"):
		print("Serang")
		anim.play("pukul")

		
	
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity



func is_attacking():
	if anim.animation == "pukul" && anim.frame < 4:
		return true
	else: 
		return false

func _on_area_2d_body_entered(body):
	print("Terkena object")
	if body.is_in_group("Enemy"):
		body.queue_free()
