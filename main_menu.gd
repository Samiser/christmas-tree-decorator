extends Control

@onready var background_timer: Timer = $BackgroundTimer
@onready var background: Background = $Background
@onready var sequence_player: SequencePlayer = $SequencePlayer
@onready var start_button: Button = $StartButton

const TREE = preload("uid://ctakbenas6ebq")

var last_note: Note

func _play_random_note() -> void:
	var note = Note.new(randi_range(0, len(Note.NAMES) - 1))
	while last_note and note.pitch == last_note.pitch:
		note = Note.new(randi_range(0, len(Note.NAMES) - 1)) 
	sequence_player.play_note(note)
	background.change_color(note.get_color())
	last_note = note

func _ready() -> void:
	_play_random_note()
	background_timer.timeout.connect(_play_random_note)
	start_button.pressed.connect(func() -> void: get_tree().change_scene_to_packed(TREE))
