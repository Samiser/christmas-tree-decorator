class_name PuzzleManager
extends Node

var puzzles: Array[Puzzle] = []

func _ready() -> void:
	_create_puzzles()

func _create_puzzles():
	puzzles.append(_create_puzzle_1())
	puzzles.append(_create_puzzle_2())

func _create_puzzle_1() -> Puzzle:
	var puzzle = Puzzle.new()
	
	var target = Sequence.new()
	target.set_length(3)
	target.set_note(0, 0, Sequence.Timbre.BELL)
	target.set_note(1, 0, Sequence.Timbre.BELL)
	target.set_note(2, 0, Sequence.Timbre.BELL)
	
	puzzle.constraints.append(Constraint.SequenceMatch.new(target))
	
	return puzzle

func _create_puzzle_2() -> Puzzle:
	var puzzle = Puzzle.new()
	
	var target = Sequence.new()
	target.set_length(4)
	target.set_note(0, 0, Sequence.Timbre.LIGHT)
	target.set_note(1, 0, Sequence.Timbre.LIGHT)
	target.set_note(2, 0, Sequence.Timbre.LIGHT)
	target.set_note(3, 0, Sequence.Timbre.LIGHT)
	
	puzzle.constraints.append(Constraint.SequenceMatch.new(target))
	
	return puzzle

func get_puzzle(index: int) -> Puzzle:
	if index >= 0 and index < puzzles.size():
		return puzzles[index]
	return null
