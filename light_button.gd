extends ColorRect

@export var note_label : RichTextLabel
var main_tree : tree
var index := 0
var highlighted := false

func _ready() -> void:
	modulate.a = 0.6

func _on_mouse_entered() -> void:
	highlighted = true
	modulate.a = 1
	size.y = 40
	position.y = -8

func _on_mouse_exited() -> void:
	highlighted = false
	modulate.a = 0.6
	size.y = 32
	position.y = 0

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click"):
		main_tree.select_colour(index)
