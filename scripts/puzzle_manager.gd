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
	puzzle.constraints = [
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(1, 4),
	]
	return puzzle

func _create_puzzle_2() -> Puzzle:
	var puzzle = Puzzle.new()
	puzzle.constraints = [
		Constraint.PitchAtIndex.new(0, 7),
		Constraint.SamePitch.new(1, 2),
	]
	return puzzle

func _create_puzzle_3() -> Puzzle:
	var puzzle = Puzzle.new()
	puzzle.constraints = [
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(3, 7),
		Constraint.DifferentPitch.new(1, 2),
		Constraint.DifferentPitch.new(0, 1),
	]
	return puzzle

func get_puzzle(index: int) -> Puzzle:
	if index >= 0 and index < puzzles.size():
		return puzzles[index]
	return null
