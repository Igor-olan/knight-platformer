extends Node2D

@onready var gamemanager = %Gamemanager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var finish_ui: Panel = $finishUI
@onready var points: Label = %Points

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_finish_area_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		await get_tree().create_timer(0.5).timeout
		print('Finished!')
		body.can_move = false
		points.text = "Finished! \n Your score is " + str(gamemanager.score) + "."
		animation_player.play("win")
		finish_ui.fade_in()
