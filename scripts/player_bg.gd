extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_alive = true

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
			
	var direction = 1

	if ray_cast_2d.is_colliding():
		velocity.y = -300

	if is_on_floor():
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
