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
	# 2 slots - Intro to Higher
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.HigherThan.new(1, 0),
	])
	return puzzle

static func _puzzle_2() -> Puzzle:
	# 4 slots - Zig-zag pattern
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 2),
		Constraint.HigherThan.new(1, 0),
		Constraint.LowerThan.new(2, 1),
		Constraint.HigherThan.new(3, 2),
	])
	return puzzle

static func _puzzle_3() -> Puzzle:
	# 6 slots - Introduces Ascending
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.Ascending.new(0, 3),
		Constraint.LowerThan.new(3, 2),
		Constraint.SamePitch.new(3, 5),
	])
	return puzzle

static func _puzzle_4() -> Puzzle:
	# 8 slots - Valley shape
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 4),
		Constraint.Descending.new(0, 4),
		Constraint.Ascending.new(4, 4),
		Constraint.LowerThan.new(4, 3),
	])
	return puzzle

static func _puzzle_5() -> Puzzle:
	# 10 slots - Mountain shape
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.Ascending.new(0, 5),
		Constraint.Descending.new(5, 5),
		Constraint.SamePitch.new(4, 5),
	])
	return puzzle

static func _puzzle_6() -> Puzzle:
	# 12 slots - Melody: Joy to the World
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 7),
		Constraint.PitchAtIndex.new(7, 0),
		Constraint.Descending.new(0, 8),
		Constraint.SamePitch.new(0, 8),
		Constraint.Descending.new(8, 4),
	])
	return puzzle
