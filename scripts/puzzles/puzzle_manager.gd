class_name PuzzleManager
extends RefCounted

var _puzzles: Array[Puzzle] = []

func _init(puzzles: Array[Puzzle]) -> void:
	_puzzles = puzzles

func get_puzzle(index: int) -> Puzzle:
	if index >= 0 and index < _puzzles.size():
		return _puzzles[index]
	return null

func puzzle_count() -> int:
	return len(_puzzles)
