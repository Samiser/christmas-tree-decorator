class_name SequencePlayer
extends Node

@onready var bell_player: AudioStreamPlayer = $BellPlayer

var is_playing: bool = false

signal note_played(index: int, note: Note)
signal playback_finished

func play_note(note: Note):
	bell_player.pitch_scale = note.get_scale()
	bell_player.play()

func play_sequence(sequence: Sequence, interval: float = 0.3):
	if is_playing:
		return
	is_playing = true
	
	for i in sequence.length:
		if sequence.notes.has(i):
			var note = sequence.notes[i]
			play_note(note)
			note_played.emit(i, note)
		await get_tree().create_timer(interval).timeout
	
	is_playing = false
	playback_finished.emit()

func stop():
	is_playing = false
