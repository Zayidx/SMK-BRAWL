extends CharacterBody2D
@export var gravity = 30
@export var hp = 100

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

enum states{
	Wander,
	Chase
}

var current_state = states.Wander

func _ready():
	player = get_tree().get_first_node_in_group("player")
	chase_timer.timeout.connect(on_timer_timeout)

func _physics_process(_delta):
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
	
func handle_movement() -> void:
	var direction = global_position - player.global_position
	
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
				anim.play("walk")
				anim.flip_h = false
			else:
				current_speed = -chase_speed
				anim.play("walk")
				anim.flip_h = true


	velocity.x = current_speed

func track_player():
	if player == null:
		return
		
	var direction_to_player : Vector2 = Vector2(player.position.x, player.position.y - 8)\
	- player_tracker_raycast.position
	
	player_tracker_pivot.look_at(direction_to_player)

func _take_damage(damage):
	hp -= damage

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
	if body.is_in_group == "player":
		anim.play("attack")




func _on_attack_delay_timeout():
	$Timer.start()
	$Enemyarea/CollisionShape2D.disabled = false


func _on_timer_timeout():
	$Enemyarea/CollisionShape2D.disabled = true
