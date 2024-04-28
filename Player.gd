class_name PlayerEntity
extends CharacterBody2D
@export var knockbackStrength = 800
var dir = 1
signal knockback

@export var speed = 400
@export var gravity = 30
@export var jump_force = 600
@onready var anim = get_node("AnimatedSprite")
@export var hp = 2500
var motion = Vector2()
var knockback_dir= Vector2()
var knockback_wait = 10
const UP =Vector2(0,-1)


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
		var audiostream = ResourceLoader.load("res://Backsound/jump.mp3")
		$playerjump.stream = audiostream
		$playerjump.play()
	elif Input.is_action_pressed("move_left") && !is_attacking():	
		anim.play("Run")
		anim.flip_h = true
		velocity.x = -speed
		dir = -1
	elif Input.is_action_pressed("move_right") && !is_attacking():
		anim.play("Run")
		velocity.x = speed
		anim.flip_h = false
		dir = 1
		
	
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
	
	for body in $Player.get_overlapping_bodies():
		if knockback_wait <= 0 and body.get("NAME") == "enemy":
			emit_signal("knockback") 
			knockback_wait = 10
	knockback_wait -= 1
	
	
	
	update_health()
	move_and_slide()

func attack_with_knockback():
	pass

func _on_area_2d_body_entered(body):
	print("Terkena object")
	if body.is_in_group("Enemy"):
		body.queue_free()


func is_attacking():
	if anim.animation == "attack" && anim.frame < 4:
		return true
	else: 
		return false


func _on_Player_body_entered(body):
	if body.is_in_group("enemy"):
		body._take_damage(20)
		if anim.flip_h == false :
			body.velocity.x = knockbackStrength
		else:
			body.velocity.x = -knockbackStrength

func take_damage(damage):
	hp -= damage
	if $TimerTakeDamage.is_stopped():
		$AnimatedSprite.material.set_shader_parameter("opacity", 1.0);
		$AnimatedSprite.material.set_shader_parameter("r", 1.0);
		$AnimatedSprite.material.set_shader_parameter("g", 0);
		$AnimatedSprite.material.set_shader_parameter("b", 0);
		$AnimatedSprite.material.set_shader_parameter("mix_color", 0.7);
		$TimerTakeDamage.start(0)

func update_health():
	var healthbar = $healthbar
	
	healthbar.value = hp
	
	if hp >= 2500:
		healthbar.visible = true
	else:
		healthbar.visible = true
	if hp == 0:
		print("kebuka")
		get_tree().change_scene_to_file("res://lose.tscn")


func _on_timer_take_damage_timeout():
	$TimerTakeDamage.stop()
	$AnimatedSprite.material.set_shader_parameter("opacity", 1.0);
	$AnimatedSprite.material.set_shader_parameter("mix_color", 0)


func _on_regen_timer_timeout():
	if hp < 2500:
		hp = hp + 250
		if hp > 2500:
			hp = 2500
	if hp == 0:
		hp = 0
		

