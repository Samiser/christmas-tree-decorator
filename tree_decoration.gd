extends ColorRect
var current_note : Note
var color_pitches := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_decoration(note: Note) -> void:
	current_note = note
	color = color_pitches[note.pitch]
	visible = true
