extends CharacterBody2D
const NAME = "enemy"
@export var enemydamage = 500
var damage = enemydamage / 2500
@export var gravity = 30
@export var hp = 100
var attack = true
@onready var wall_raycast_left = $Wall_Checks/Wall_Raycast_Left as RayCast2D
@onready var wall_raycast_right = $Wall_Checks/Wall_Raycast_Right as RayCast2D
@onready var floor_raycast_left = $Floor_Checks/Floor_Raycast_Left as RayCast2D
@onready var floor_raycast_right = $Floor_Checks/Floor_Raycast_Right as RayCast2D
@onready var player_tracker_raycast =$Player_Tracker_Pivot/Player_Track_Raycast as RayCast2D
@onready var player_tracker_pivot = $Player_Tracker_Pivot as Node2D
@onready var Sprite_2d = $Sprite_2d as Sprite2D
@onready var chase_timer = $Chase_Timer as Timer

@onready var anim = $AnimatedSprite2D

@export var wander_speed : float = 40.0
@export var chase_speed : float = 80.0

var current_speed : float  = 0.0
var player_found : bool = false 
var player : PlayerEntity = null
var is_attack_ready = false

var dir = 1
var knockback_dir
var knockback

enum states{
	Wander,
	Chase
}

var current_state = states.Wander

func _ready():
	anim.play("walk")
	player = get_tree().get_first_node_in_group("player")
	chase_timer.timeout.connect(on_timer_timeout)

func _physics_process(_delta):
	update_health()
	handle_vision()
	track_player()
	handle_movement()
	move_and_slide()
	print(hp)
	velocity.x = 0
	if hp <= 0:
		queue_free()
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1500:
			velocity.y = 500
	if $attack_delay.time_left == $attack_delay.wait_time:
		is_attack_ready = true
	else:
		is_attack_ready = false 
	
func handle_movement() -> void:
	var direction = null
	if player != null && direction == null:
		direction = global_position - player.global_position
	else:
		return
	
	if current_state == states.Wander:
		if floor_raycast_right.is_colliding() != true: 
			current_speed = -wander_speed
		if floor_raycast_left.is_colliding() != true: 
			current_speed = wander_speed
		if wall_raycast_right.is_colliding():
			current_speed = wander_speed
		if wall_raycast_left.is_colliding():
			current_speed = wander_speed
	
	if current_state == states.Chase:
		if player_found == true:
			if direction.x < 0:
				current_speed = chase_speed
				anim.flip_h = false
				if is_attacking() == false:
					anim.play("walk")
				
			else:
				current_speed = -chase_speed
				
				
				anim.flip_h = true
				
				if is_attacking() == false:
					anim.play("walk")
	velocity.x = current_speed

func track_player():
	if player == null:
		return
		
	if global_position.distance_to(player.global_position) < 78 :
		anim.play("attack")
		player.take_damage(10)
		
		
	var direction_to_player : Vector2 = Vector2(player.position.x, player.position.y - 8)\
	- player_tracker_raycast.position
	
	player_tracker_pivot.look_at(direction_to_player)

func _take_damage(damage):
	if knockback == true:
		velocity.y = -200
		velocity.x = 350 
		knockback = false
		velocity.x = -current_speed
	hp -= damage
	if $TimerTakeDamage.is_stopped():
		$AnimatedSprite2D.material.set_shader_parameter("opacity", 1.0);
		$AnimatedSprite2D.material.set_shader_parameter("r", 1.0);
		$AnimatedSprite2D.material.set_shader_parameter("g", 0);
		$AnimatedSprite2D.material.set_shader_parameter("b", 0);
		$AnimatedSprite2D.material.set_shader_parameter("mix_color", 0.7);
		$TimerTakeDamage.start(0)

func handle_vision():
	if player_tracker_raycast.is_colliding():
		var collision_result = player_tracker_raycast.get_collider()
		
		if collision_result != player:
			return
		else:
			current_state = states.Chase
			chase_timer.start(1)
			player_found = true
	else :
		player_found = false
		

func on_timer_timeout() -> void:
	if player_found == false:
		current_state = states.Wander

func _on_enemyarea_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(10)
		anim.play("attack")
		
func _on_enemyarea_body_exited(body):
	if body.name == "player":
		attack = false
		
func is_attacking():
	if anim.animation == "attack" && anim.frame > 2:
		return false
	else:
		return true
		print("true")

func update_health():
	var healthbar = $healthbar
	
	healthbar.value = hp
	
	if hp >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	
	if hp == 0:
		print("kebuka")
		get_tree().change_scene_to_file("res://win.tscn")
		

func _on_timer_take_damage_timeout():
	$TimerTakeDamage.stop()
	$AnimatedSprite2D.material.set_shader_parameter("opacity", 1.0);
	$AnimatedSprite2D.material.set_shader_parameter("mix_color", 0)


func _on_player_knockback():
	var player_dir = get_parent().get_node("Player").dir 
	knockback_dir = player_dir
	dir = knockback_dir * -1
	knockback = true
	
