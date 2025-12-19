class_name PuzzleManager
extends RefCounted

var puzzles: Array[Puzzle] = []

func _init() -> void:
	_create_puzzles()

func _create_puzzles():
	puzzles.append(_create_puzzle_1())
	puzzles.append(_create_puzzle_2())

func _create_puzzle_1() -> Puzzle:
	var puzzle = Puzzle.new()
	
	var target = Sequence.new()
	target.length = 2
	target.set_note(0, Note.new(0, Note.Timbre.BELL))
	target.set_note(1, Note.new(0, Note.Timbre.BELL))
	
	puzzle.constraints.append(Constraint.SequenceMatch.new(target))
	
	return puzzle

func _create_puzzle_2() -> Puzzle:
	var puzzle = Puzzle.new()
	
	var target = Sequence.new()
	target.length = 4
	target.set_note(0, Note.new(0, Note.Timbre.BELL))
	target.set_note(2, Note.new(0, Note.Timbre.BELL))
	
	puzzle.constraints.append(Constraint.SequenceMatch.new(target))
	
	return puzzle

func get_puzzle(index: int) -> Puzzle:
	if index >= 0 and index < puzzles.size():
		return puzzles[index]
	return null
