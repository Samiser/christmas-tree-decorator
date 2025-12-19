extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@export var tree_height = 7;
@export var tree_tile : PackedScene
@export var tree_row : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_tree()

func _create_tree() -> void:
	_clear_tree()
	for row in tree_height:
		var new_row := tree_row.instantiate()
		v_box_container.add_child(new_row)
		
		for width_index in row * 2:
			var tile := tree_tile.instantiate()
			new_row.add_child(tile)

func _clear_tree() -> void:
	var children := v_box_container.get_children()
	for child in children:
		child.queue_free()

func get_row_decorations(row_index : int) -> Sequence:
	var notes : Array[Note]
	
	row_index += 1 # excludes the parent node
	
	if row_index < 0 || row_index > tree_height:
		print("Humbug! The row index for get_row_decorations is out of bounds!!!")
		return null
	
	var row_tiles := v_box_container.get_child(row_index).get_children()
	for tile in row_tiles:
		notes.append(tile.decoration.current_note)
	
	var sequence = Sequence.new()
	sequence.length = len(notes)
	for i in len(notes):
		if notes[i] != null:
			sequence.set_note(i, notes[i])
	
	return sequence



func _input(event):
	if event is InputEventKey and event.pressed:
		if KEY_1 <= event.keycode and event.keycode <= KEY_6:
			$SequencePlayer.play_sequence(get_row_decorations(event.keycode - 49))
