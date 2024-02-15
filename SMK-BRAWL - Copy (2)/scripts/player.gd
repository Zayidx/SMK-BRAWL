extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 1000

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _physics_process(delta):
	if !is_on_floor(): 
		velocity.y += gravity
		if velocity.y > 1500: 
			velocity.y = 500         
			
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction !=0:
		sprite.flip_h = (horizontal_direction == -1)
	
	move_and_slide()		
	
	update_animations(horizontal_direction)
	
	if Input.is_action_just_pressed("Attacking"):
		print("Serang")
		ap.play("pukul")
		
func _on_area_2d_body_entered(body):
	print("Terkena object")
	if body.is_in_group("Enemy"):
		body.queue_free()
	
	
func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("walk")
	else:
		if velocity.y < 0:
			ap.play("lompat")
		elif velocity.y > 0:
			ap.play("jatuh")
		
			
