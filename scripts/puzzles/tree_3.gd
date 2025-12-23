class_name TreeThreePuzzles
extends Puzzles

static func get_puzzles() -> Array[Puzzle]:
	return [
		_puzzle_1(),
		_puzzle_2(),
		_puzzle_3(),
		_puzzle_4(),
		_puzzle_5(),
		_puzzle_6(),
		_puzzle_7(),
		_puzzle_8(),
	]

static func _puzzle_1() -> Puzzle:
	# 2 slots - Intro to IsHighest/IsLowest
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.IsLowest.new(0),
		Constraint.IsHighest.new(1),
		Constraint.DifferentPitch.new(0, 1),
	])
	return puzzle

static func _puzzle_2() -> Puzzle:
	# 4 slots - Introduces PitchCount
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.IsHighest.new(1),
		Constraint.IsLowest.new(2),
		Constraint.PitchCount.new(1, 2),
	])
	return puzzle

static func _puzzle_3() -> Puzzle:
	# 6 slots - Count with positional
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(5, 4),
		Constraint.PitchCount.new(2, 2),
		Constraint.IsHighest.new(2),
	])
	return puzzle

static func _puzzle_4() -> Puzzle:
	# 8 slots - Introduces NoAdjacentMatch
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.NoAdjacentMatch.new(),
		Constraint.SamePitch.new(0, 4),
		Constraint.SamePitch.new(3, 7),
		Constraint.SamePitch.new(1, 6),
		Constraint.SamePitch.new(2, 5)
	])
	return puzzle

static func _puzzle_5() -> Puzzle:
	# 10 slots - Complex counting
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.IsLowest.new(0),
		Constraint.IsHighest.new(4),
		Constraint.PitchCount.new(3, 3),
		Constraint.PitchCount.new(4, 2),
		Constraint.NoAdjacentMatch.new(),
	])
	return puzzle

static func _puzzle_6() -> Puzzle:
	# 12 slots - Building complexity
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 0),
		Constraint.PitchAtIndex.new(11, 0),
		Constraint.PitchCount.new(1, 3),
		Constraint.PitchCount.new(2, 2),
		Constraint.IsHighest.new(5),
		Constraint.SamePitch.new(2, 8),
		Constraint.NoAdjacentMatch.new(),
	])
	return puzzle

static func _puzzle_7() -> Puzzle:
	# 14 slots - Melody: Jingle Bells Part 1
	# E E E / E E E / E G C D E /
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(0, 2),
		Constraint.PitchAtIndex.new(9, 4),
		Constraint.PitchAtIndex.new(10, 0),
		Constraint.PitchAtIndex.new(11, 1),
		Constraint.SameSection.new(0, 4, 3),
		Constraint.SamePitch.new(0, 1),
		Constraint.SamePitch.new(2, 8),
		Constraint.SamePitch.new(8, 1),
		Constraint.SamePitch.new(4, 12),
		Constraint.IsEmpty.new(3),
		Constraint.IsEmpty.new(7),
		Constraint.IsEmpty.new(13),
	])
	return puzzle


static func _puzzle_8() -> Puzzle:
	# 16 slots - Melody: Jingle Bells Part 2
	# / / F F F / F E E / G G F D C /
	var puzzle = Puzzle.new()
	puzzle.set_constraints([
		Constraint.PitchAtIndex.new(6, 3),
		Constraint.PitchAtIndex.new(7, 2),
		Constraint.PitchAtIndex.new(10, 4),
		Constraint.PitchAtIndex.new(13, 1),
		Constraint.SamePitch.new(2, 6),
		Constraint.SamePitch.new(4, 2),
		Constraint.SamePitch.new(3, 4),
		Constraint.SamePitch.new(2, 12),
		Constraint.SamePitch.new(7, 8),
		Constraint.SamePitch.new(11, 10),
		Constraint.Descending.new(11, 4),
		Constraint.IsEmpty.new(15),
	])
	return puzzle
