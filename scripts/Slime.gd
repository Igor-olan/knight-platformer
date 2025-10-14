extends Node2D

const SPEED = 40

var direction = 1
var is_alive = true

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var gamemanager = %Gamemanager
@onready var stomp: CollisionShape2D = $stomp
@onready var killzone: Area2D = $Killzone

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):	
	if not is_alive:
		return
	
	if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false
	position.x += direction * SPEED * delta

func get_stomped():
	if not is_alive:
		return
		
	is_alive = false
	
	killzone.queue_free()
	stomp.queue_free()
	gamemanager.kill_enemies()
	animated_sprite.play("death")
	timer.start()

func _on_timer_timeout():
	queue_free()
