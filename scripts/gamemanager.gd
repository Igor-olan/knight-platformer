extends Node

var score = 0
var is_paused = false

@onready var player: CharacterBody2D = $"../Player"
@onready var finish_menu: Node2D = $"../Player/Camera2D/CanvasLayer/finish_menu"
@onready var finish_area: Area2D = $"../finishArea"
@onready var pause_menu = $"../Player/Camera2D/CanvasLayer/PauseMenu"



func _ready():
	pause_menu.visible = false
	player.can_move = false
	await get_tree().create_timer(0.5).timeout
	player.can_move = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and not is_paused:
		pause_menu.fade_in()
		await get_tree().create_timer(0.2).timeout
		get_tree().paused = true
		is_paused = true
	elif Input.is_action_just_pressed("pause") and is_paused:
		pause_menu.fade_out()
		await get_tree().create_timer(0.2).timeout
		get_tree().paused = false
		is_paused = false

func add_point():
	score += 1
	print("+1")

func kill_enemies():
	score += 1
	print("You killed an enemy! +1")
