extends ColorRect

var main_tree : tree
var index := 0
var highlighted := false

func _on_mouse_entered() -> void:
	highlighted = true

func _on_mouse_exited() -> void:
	highlighted = false

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click"):
		main_tree.selected_light = index
