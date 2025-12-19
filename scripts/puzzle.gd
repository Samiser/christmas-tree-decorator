class_name Puzzle
extends Resource

var constraints: Array[Constraint] = []

func set_constraints(new_constraints: Array[Constraint]) -> void:
	constraints.clear()
	for constraint in new_constraints:
		constraints.append(constraint)

func check_solution(player_sequence: Sequence) -> bool:
	for constraint in constraints:
		if not constraint.check(player_sequence):
			return false
	return true
