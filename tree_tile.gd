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

	if Input.is_action_just_pressed("left_click"):
		var pitch = 0
		if $decoration.current_note != null:
			pitch = $decoration.current_note.pitch + 1
			if pitch > 7:
				pitch = 0
		$decoration.set_decoration(Note.new(pitch, 0))
	
	if Input.is_action_pressed("right_click"):
		$decoration.remove_decoration()
