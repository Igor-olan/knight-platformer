extends ColorRect

@onready var brightness_overlay: ColorRect = $"."

func _ready() -> void:
	brightness_overlay.visible = false

func set_brightness(value: float) -> void:
	brightness_overlay.visible = true
	modulate.a = 1.0 - clamp(value, 0.0, 1.0)
