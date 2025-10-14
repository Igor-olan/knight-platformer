extends Panel

@onready var finish_ui: Panel = $"."

func _ready():
	finish_ui.visible = true
	finish_ui.modulate.a = 0.0

func fade_in():
	var tween = create_tween()
	tween.tween_property(finish_ui, "modulate:a", 1.0, 0.5)
