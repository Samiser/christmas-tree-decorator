extends ColorRect

@onready var decoration: ColorRect = $decoration
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
		var test_note = Note.new(randi_range(0, 7), 0)
		$decoration.set_decoration(test_note)
