extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var menu_ui: Panel = $"."
@onready var sure = $sure

func _ready():
	menu_ui.visible = true
	menu_ui.modulate.a = 0.0
	sure.visible = false
	sure.modulate.a = 0.0
	fade_in()



func fade_in():
	var tween = create_tween()
	tween.tween_property(menu_ui, "modulate:a", 1.0, 0.2)

func fade_out():
	var tween = create_tween()
	tween.tween_property(menu_ui, "modulate:a", 0.0, 0.2)
	
func fade_in_quit():
	var tween = create_tween()
	tween.tween_property(sure, "modulate:a", 1.0, 0.2)

func fade_out_quit():
	var tween = create_tween()
	tween.tween_property(sure, "modulate:a", 0.0, 0.2)

func quit():
	sure.visible = true
	fade_in_quit()

func _process(delta: float) -> void:
	animated_sprite_2d.play('idle')

func _on_start_game_pressed():
	fade_out()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	quit()

func _on_yes_pressed():
	fade_out()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()

func _on_no_pressed():
	fade_out_quit()
	await get_tree().create_timer(0.2).timeout
	sure.visible = false
