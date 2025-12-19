extends ColorRect

var decoration := 0
var highlighted := false

func _ready() -> void:
	color = Color.DARK_GREEN

func _on_mouse_entered() -> void:
	color = Color.GREEN
	highlighted = true

func _on_mouse_exited() -> void:
	color = Color.DARK_GREEN
	highlighted = false

func _input(event):
	if !highlighted:
		return

	if event.is_pressed() and event is InputEventMouseButton:
		decoration += 1
		if decoration > 1:
			decoration = 0
		$decoration.visible = decoration == 1
