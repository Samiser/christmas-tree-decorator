class_name LightButton
extends TextureRect

@export var note_label : RichTextLabel
@onready var bell_player: AudioStreamPlayer = $BellPlayer
var index := 0
var highlighted := false

signal color_selected(color: int)

func _ready() -> void:
	modulate.a = 0.6

func _play_note() -> void:
	var note: Note = Note.new(index)
	bell_player.pitch_scale = note.get_scale()
	bell_player.play()

func _on_mouse_entered() -> void:
	highlighted = true
	modulate.a = 1
	size.y = 40
	position.y = -8

func hide_label() -> void:
	note_label.hide()

func _on_mouse_exited() -> void:
	highlighted = false
	modulate.a = 0.6
	size.y = 32
	position.y = 0

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click"):
		#_play_note()
		color_selected.emit(index)
