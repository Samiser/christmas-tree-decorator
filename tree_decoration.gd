extends ColorRect
var current_note : Note
var color_pitches := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]
var tween : Tween

func _ready() -> void:
	modulate.a = 0.5

func set_decoration(note: Note) -> void:
	current_note = note
	color = color_pitches[note.pitch]
	visible = true
	light_decoration() 

func remove_decoration() -> void:
	current_note = null
	visible = false

func light_decoration() -> void:
	if tween != null and tween.is_running():
		return
		
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.25)
	tween.parallel().tween_property(self, "position:y", position.y - 24, 0.25)
	
	await tween.finished
	tween = get_tree().create_tween()
	
	tween.tween_property(self, "modulate:a", 0.5, 0.5)
	tween.parallel().tween_property(self, "position:y", position.y + 24, 0.5)
