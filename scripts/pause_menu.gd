extends Panel

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pause_menu = $"."
@onready var sure_m = $sure_m
@onready var sure_q = $sure_q
@onready var gamemanager = %Gamemanager

func _ready():
	pause_menu.visible = false
	sure_m.visible = false
	sure_q.visible = false
	pause_menu.modulate.a = 0.0
	sure_m.modulate.a = 0.0
	sure_q.modulate.a = 0.0

func fade_in():
	pause_menu.visible = true
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate:a", 1.0, 0.2)
	
func fade_out():
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate:a", 0.0, 0.2)
	await get_tree().create_timer(0.2).timeout
	pause_menu.visible = false

func fade_in_m():
	var tween = create_tween()
	tween.tween_property(sure_m, "modulate:a", 1.0, 0.2)
	
func fade_out_m():
	var tween = create_tween()
	tween.tween_property(sure_m, "modulate:a", 0.0, 0.2)

func fade_in_q():
	var tween = create_tween()
	tween.tween_property(sure_q, "modulate:a", 1.0, 0.2)
	
func fade_out_q():
	var tween = create_tween()
	tween.tween_property(sure_q, "modulate:a", 0.0, 0.2)
	
	
	
func _on_resume_pressed() -> void:
	fade_out()
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false
	gamemanager.is_paused = false



func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_menu_pressed():
	sure_m.visible = true
	fade_in_m()

func _on_quit_pressed() -> void:
	sure_q.visible = true
	fade_in_q()
	
func _on_yes_m_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_no_m_pressed():
	fade_out_m()
	await get_tree().create_timer(0.2).timeout
	sure_m.visible = false

func _on_yes_q_pressed():
	get_tree().quit()

func _on_no_q_pressed():
	fade_out_q()
	await get_tree().create_timer(0.2).timeout
	sure_q.visible = false
