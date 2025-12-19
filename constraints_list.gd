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
		var label = RichTextLabel.new()
		label.bbcode_enabled = true
		label.fit_content = true
		label.text = constraint.description()
		add_child(label)

func set_constraint_complete(index: int, complete: bool):
	if index < 0 or index >= get_child_count():
		return
	
	var label = get_child(index) as RichTextLabel
	var text = current_puzzle.constraints[index].description()
	
	if complete:
		label.text = "[color=#ffffff99][i][s]%s[/s][/i][/color]" % text
	else:
		label.text = text
