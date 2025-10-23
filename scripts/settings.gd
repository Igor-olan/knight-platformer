extends Panel

@onready var main: HSlider = $main
@onready var bgm: HSlider = $bgm
@onready var bright: HSlider = $bright
@onready var back: Button = $back
@onready var settings: Panel = $"."
@onready var sfx: HSlider = $sfx
@onready var brightness_overlay: ColorRect = $brightnessOverlay
@onready var pickup: AudioStreamPlayer2D = $Pickup

func _ready() -> void:
	settings.visible = false
	settings.modulate.a = 0.0

func fade_in():
	settings.visible = true
	var tween = create_tween()
	tween.tween_property(settings, 'modulate:a', 1.0, 0.2)
 
func fade_out():
	var tween = create_tween()
	tween.tween_property(settings, "modulate:a", 0.0, 0.2)
	await get_tree().create_timer(0.2).timeout
	settings.visible = false

func _on_back_pressed() -> void:
	fade_out()
	await get_tree().create_timer(0.2).timeout
	settings.visible = false

func _on_main_changed() -> void:
	pass # Replace with function body.

func _on_bgm_changed() -> void:
	pass # Replace with function body.

func _on_sfx_value_changed(sfx_value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_value))

func _on_sfx_drag_ended(value_changed: bool) -> void:
	pickup.play()

func _on_bright_value_changed(value: float) -> void:
	brightness_overlay.set_brightness(value)
