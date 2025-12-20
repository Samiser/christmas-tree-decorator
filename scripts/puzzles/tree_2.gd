class_name TreeTwoPuzzles
extends Puzzles

static func get_puzzles() -> Array[Puzzle]:
	return [
		_puzzle_1(),
		_puzzle_2(),
		_puzzle_3(),
		_puzzle_4(),
		_puzzle_5(),
		_puzzle_6(),
	]

static func _puzzle_1() -> Puzzle:
	# 2 slots - Pure tutorial: place two specific notes
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(1, 2),
	])
	return puzzle

static func _puzzle_2() -> Puzzle:
	# 4 slots - Introduces matching
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(3, 4),
		Constraint.SamePitch.new(1, 2),
	])
	return puzzle

static func _puzzle_3() -> Puzzle:
	# 6 slots - Introduces different pitches
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(5, 0),
		Constraint.SamePitch.new(2, 3),
		Constraint.DifferentPitch.new(1, 2),
		Constraint.DifferentPitch.new(3, 4),
	])
	return puzzle

static func _puzzle_4() -> Puzzle:
	# 8 slots - Chained matching
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 2),
		Constraint.PitchAtIndex.new(7, 4),
		Constraint.SamePitch.new(0, 3),
		Constraint.SamePitch.new(1, 2),
		Constraint.SamePitch.new(4, 5),
		Constraint.DifferentPitch.new(1, 4),
	])
	return puzzle

static func _puzzle_5() -> Puzzle:
	# 10 slots - More deduction required
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(9, 2),
		Constraint.SamePitch.new(0, 5),
		Constraint.SamePitch.new(2, 7),
		Constraint.SamePitch.new(4, 9),
		Constraint.DifferentPitch.new(1, 2),
		Constraint.DifferentPitch.new(3, 4),
		Constraint.DifferentPitch.new(6, 7),
	])
	return puzzle

static func _puzzle_6() -> Puzzle:
	# 12 slots - Finale for tree 1
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 2),
		Constraint.PitchAtIndex.new(11, 0),
		Constraint.SamePitch.new(0, 1),
		Constraint.SamePitch.new(2, 5),
		Constraint.SamePitch.new(3, 4),
		Constraint.SamePitch.new(6, 9),
		Constraint.SamePitch.new(7, 8),
		Constraint.DifferentPitch.new(0, 2),
		Constraint.DifferentPitch.new(2, 3),
		Constraint.DifferentPitch.new(5, 6),
		Constraint.DifferentPitch.new(9, 10),
	])
	return puzzle
