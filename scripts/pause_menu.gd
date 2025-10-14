extends Panel

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var menu_ui: Panel = $"."

func _ready():
	menu_ui.visible = true
	menu_ui.modulate.a = 0.0

func fade_in():
	var tween = create_tween()
	tween.tween_property(menu_ui, "modulate:a", 1.0, 0.2)
	
func fade_out():
	var tween = create_tween()
	tween.tween_property(menu_ui, "modulate:a", 0.0, 0.2)


func _on_resume_pressed() -> void:
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
