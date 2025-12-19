@abstract
class_name Constraint
extends Resource

@abstract func description() -> String
@abstract func check(sequence: Sequence) -> bool

func pitch_name(pitch: int) -> String:
	var names = ["C", "D", "E", "F", "G", "A", "B"]
	return names[pitch % 8]

class PitchAtIndex extends Constraint:
	var index: int
	var pitch: int
	
	func _init(i: int, p: int):
		index = i
		pitch = p
	
	func description() -> String:
		return "Slot %d is %s" % [index + 1, pitch_name(pitch)]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(index):
			return false
		return sequence.notes[index].pitch == pitch

class HigherThan extends Constraint:
	var higher_index: int
	var lower_index: int
	
	func _init(hi: int, lo: int):
		higher_index = hi
		lower_index = lo
	
	func description() -> String:
		return "Slot %d is higher than slot %d" % [higher_index + 1, lower_index + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(higher_index) or not sequence.notes.has(lower_index):
			return false
		return sequence.notes[higher_index].pitch > sequence.notes[lower_index].pitch


class LowerThan extends Constraint:
	var lower_index: int
	var higher_index: int
	
	func _init(lo: int, hi: int):
		lower_index = lo
		higher_index = hi
	
	func description() -> String:
		return "Slot %d is lower than slot %d" % [lower_index + 1, higher_index + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(lower_index) or not sequence.notes.has(higher_index):
			return false
		return sequence.notes[lower_index].pitch < sequence.notes[higher_index].pitch

class SamePitch extends Constraint:
	var index_a: int
	var index_b: int
	
	func _init(a: int, b: int):
		index_a = a
		index_b = b
	
	func description() -> String:
		return "Slots %d and %d are the same" % [index_a + 1, index_b + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(index_a) or not sequence.notes.has(index_b):
			return false
		return sequence.notes[index_a].pitch == sequence.notes[index_b].pitch


class DifferentPitch extends Constraint:
	var index_a: int
	var index_b: int
	
	func _init(a: int, b: int):
		index_a = a
		index_b = b
	
	func description() -> String:
		return "Slots %d and %d are different" % [index_a + 1, index_b + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(index_a) or not sequence.notes.has(index_b):
			return false
		return sequence.notes[index_a].pitch != sequence.notes[index_b].pitch


class NoAdjacentMatch extends Constraint:
	func description() -> String:
		return "No two adjacent slots are the same"
	
	func check(sequence: Sequence) -> bool:
		var indices = sequence.notes.keys()
		indices.sort()
		for i in range(indices.size() - 1):
			var curr = indices[i]
			var next = indices[i + 1]
			if next == curr + 1:
				if sequence.notes[curr].pitch == sequence.notes[next].pitch:
					return false
		return true


class IsHighest extends Constraint:
	var index: int
	
	func _init(i: int):
		index = i
	
	func description() -> String:
		return "Slot %d is the highest note" % [index + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(index):
			return false
		var target_pitch = sequence.notes[index].pitch
		for other_index in sequence.notes.keys():
			if other_index != index:
				if sequence.notes[other_index].pitch >= target_pitch:
					return false
		return true


class IsLowest extends Constraint:
	var index: int
	
	func _init(i: int):
		index = i
	
	func description() -> String:
		return "Slot %d is the lowest note" % [index + 1]
	
	func check(sequence: Sequence) -> bool:
		if not sequence.notes.has(index):
			return false
		var target_pitch = sequence.notes[index].pitch
		for other_index in sequence.notes.keys():
			if other_index != index:
				if sequence.notes[other_index].pitch <= target_pitch:
					return false
		return true


class PitchCount extends Constraint:
	var pitch: int
	var count: int
	
	func _init(p: int, c: int):
		pitch = p
		count = c
	
	func description() -> String:
		return "%s appears exactly %d time(s)" % [pitch_name(pitch), count]
	
	func check(sequence: Sequence) -> bool:
		var actual_count = 0
		for note in sequence.notes.values():
			if note.pitch == pitch:
				actual_count += 1
		return actual_count == count


class Ascending extends Constraint:
	var start_index: int
	var run_length: int
	
	func _init(start: int, length: int):
		start_index = start
		run_length = length
	
	func description() -> String:
		return "Slots %d-%d ascend" % [start_index + 1, start_index + run_length]
	
	func check(sequence: Sequence) -> bool:
		for i in range(run_length - 1):
			var curr = start_index + i
			var next = start_index + i + 1
			if not sequence.notes.has(curr) or not sequence.notes.has(next):
				return false
			if sequence.notes[curr].pitch >= sequence.notes[next].pitch:
				return false
		return true


class Descending extends Constraint:
	var start_index: int
	var run_length: int
	
	func _init(start: int, length: int):
		start_index = start
		run_length = length
	
	func description() -> String:
		return "Slots %d-%d descend" % [start_index + 1, start_index + run_length]
	
	func check(sequence: Sequence) -> bool:
		for i in range(run_length - 1):
			var curr = start_index + i
			var next = start_index + i + 1
			if not sequence.notes.has(curr) or not sequence.notes.has(next):
				return false
			if sequence.notes[curr].pitch <= sequence.notes[next].pitch:
				return false
		return true
