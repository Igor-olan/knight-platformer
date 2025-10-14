extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_alive = true
var double_jump_used = false
var stomped = false
var can_move = true
var spawn_x = 0.0
var spawn_y = 0.0
var checkpoint_x = 0.0
var checkpoint_y = 0.0
var checkpoint = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var finish_menu: Node2D = $Camera2D/CanvasLayer/finish_menu

func _physics_process(delta):
	if not can_move:
		velocity.x = 0
		velocity.y += gravity * delta
		move_and_slide()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor():
		double_jump_used = false
		stomped = false
		if Input.is_action_just_pressed("jump"):
			velocity.y = -300.0
	elif not is_on_floor():
		if Input.is_action_just_pressed("jump") and not double_jump_used:
			double_jump_used = true
			velocity.y = -200.0
			
			
		
	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor() and player_alive:
		if direction == 0:
			animated_sprite.play("idle")
		elif direction > 0 or direction <0:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if velocity.y > 0:
		check_for_stomp()



func _ready():
	spawn_x = position.x
	spawn_y = position.y

func save_checkpoint(x, y):
	checkpoint_x = x
	checkpoint_y = y

func die():
	print('You died!')
	animation_player.play("death")
	velocity.y = -100
	collision.disabled == true
	timer.start()
	player_alive = false
	
func _on_timer_timeout() -> void:
	if checkpoint and not player_alive:
		position.x = checkpoint_x
		position.y = checkpoint_y
		collision.disabled == false
		player_alive = true
		
	elif not checkpoint and not player_alive:
		position.x = spawn_x
		position.y = spawn_y
		collision.disabled == false
		player_alive = true

func check_for_stomp():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position + Vector2(0, -3),
		global_position + Vector2(0, 13)
	)
	
	var result = space_state.intersect_ray(query)
	
	if result:
		var hit_body = result.collider
		# Check if it has the stomp method
		if hit_body.has_method("get_stomped") and not stomped:
			hit_body.get_stomped()
			stomped = true
			velocity.y = -200
			
