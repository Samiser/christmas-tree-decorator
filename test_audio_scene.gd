extends Node2D

func _ready() -> void:
	var sequence: Sequence = Sequence.new()
	sequence.length = 5
	sequence.set_note(0, Note.new(0, Note.Timbre.BELL))
	sequence.set_note(1, Note.new(2, Note.Timbre.BELL))
	sequence.set_note(3, Note.new(5, Note.Timbre.BELL))
	sequence.set_note(4, Note.new(4, Note.Timbre.BELL))
	$SequencePlayer.play_sequence(sequence)
