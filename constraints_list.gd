class_name ConstraintsList
extends VBoxContainer

var current_puzzle: Puzzle:
	set(value):
		current_puzzle = value
		_populate()

func _populate():
	for child in get_children():
		child.queue_free()
	
	if current_puzzle == null:
		return
	
	for constraint in current_puzzle.constraints:
		var label = Label.new()
		label.text = constraint.description()
		add_child(label)
