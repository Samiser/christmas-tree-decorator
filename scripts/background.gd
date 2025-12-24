class_name Background
extends Control

@onready var background_color: ColorRect = $BackgroundColor

func change_color(color: Color) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(background_color, "color", color, 1.0)
