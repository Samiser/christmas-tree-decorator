extends ColorRect

var current_note : Note
var tween : Tween
var main_tree : tree

@onready var bell_player: AudioStreamPlayer = $BellPlayer

func _ready() -> void:
	modulate.a = 0.7

func play_note(note: Note):
	bell_player.pitch_scale = note.get_scale()
	bell_player.play()

func set_decoration(note: Note) -> void:
	current_note = note
	color = main_tree.colour_pitches[note.pitch]
	visible = true
	play_note(note)
	light_decoration(0, current_note) 

func remove_decoration() -> void:
	current_note = null
	visible = false

func light_decoration(_index: int, note: Note) -> void:
	if (tween != null and tween.is_running() or note != current_note):
		return
		
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.25)
	tween.parallel().tween_property(self, "position:y", position.y - 24, 0.25)
	
	await tween.finished
	tween = get_tree().create_tween()
	
	tween.tween_property(self, "modulate:a", 0.7, 0.2)
	tween.parallel().tween_property(self, "position:y", position.y + 24, 0.2)
