extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 1000
func _physics_process(delta):
	if !is_on_floor(): 
		velocity.y += gravity
		if velocity.y > 1500: 
			velocity.y = 500         
			
	if Input.is_action_just_pressed("jump") && is_on_floor():
		
		velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
	velocity.x = speed * horizontal_direction
	
	if Input.is_action_just_pressed("Attacking"):
		print("Serang")
	
	move_and_slide()



func _on_melee_body_entered(body):
	print("Terkena object")
	if body.is_in_group("Enemy"):
		body.queue_free()
