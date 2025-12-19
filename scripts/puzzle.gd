class_name Puzzle
extends Resource

@export var constraints: Array[Constraint] = []

func check_solution(player_sequence: Sequence) -> bool:
	for constraint in constraints:
		if not constraint.check(player_sequence):
			return false
	return true
