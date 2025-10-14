extends Node

var score = 0

@onready var player: CharacterBody2D = $"../Player"
@onready var finish_menu: Node2D = $"../Player/Camera2D/CanvasLayer/finish_menu"
@onready var finishArea: Area2D = $"../finish"

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
	else:
		get_tree().paused = true

func _ready():
	player.can_move = false
	await get_tree().create_timer(0.5).timeout
	player.can_move = true
	
func add_point():
	score += 1
	print("+1")

func kill_enemies():
	score += 1
	print("You killed an enemy! +1")
