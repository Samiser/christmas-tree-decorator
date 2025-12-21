class_name TreeOnePuzzles
extends Puzzles

static func get_puzzles() -> Array[Puzzle]:
	return [
		_puzzle_1(),
		_puzzle_2(),
		_puzzle_3(),
		_puzzle_4(),
	]

static func _puzzle_1() -> Puzzle:
	# 2 slots - Pure tutorial
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(1, 2),
	])
	return puzzle

static func _puzzle_2() -> Puzzle:
	# 4 slots - Introduces Same
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(3, 4),
		Constraint.SamePitch.new(1, 2),
	])
	return puzzle

static func _puzzle_3() -> Puzzle:
	# 6 slots - Combines same and different
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 2),
		Constraint.PitchAtIndex.new(5, 4),
		Constraint.SamePitch.new(1, 4),
		Constraint.DifferentPitch.new(2, 3),
	])
	return puzzle

static func _puzzle_4() -> Puzzle:
	# 8 slots - Chained logic
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(7, 0),
		Constraint.SamePitch.new(0, 4),
		Constraint.SamePitch.new(1, 3),
		Constraint.DifferentPitch.new(2, 5),
		Constraint.DifferentPitch.new(5, 6),
	])
	return puzzle
