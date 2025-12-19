@abstract
class_name Constraint
extends Resource

@abstract func check(sequence: Sequence) -> bool

class SequenceMatch extends Constraint:
	var target: Sequence
	
	func _init(t: Sequence) -> void:
		target = t
	
	func check(sequence: Sequence) -> bool:
		return sequence.compare(target)
