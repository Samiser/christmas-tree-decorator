extends Control
class_name tree

var colour_pitches := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]

var selected_light := 0

@onready var tree_vbox_container: VBoxContainer = $TreeContainer
@onready var colour_container: HBoxContainer = $ColourContainer
@onready var constraints_list: ConstraintsList = $ConstraintsList

@export var tree_height = 7;
@export var tree_tile : PackedScene
@export var tree_row : PackedScene
@export var light_button : PackedScene


var puzzle_manager: PuzzleManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_display_lights()
	_create_tree()
	puzzle_manager = PuzzleManager.new()

func _create_tree() -> void:
	_clear_tree()
	for row in tree_height:
		var new_row := tree_row.instantiate()
		tree_vbox_container.add_child(new_row)
		
		for width_index in row * 2:
			var tile := tree_tile.instantiate()
			new_row.add_child(tile)
			tile.main_tree = self
			tile.decoration.main_tree = self
			$SequencePlayer.note_played.connect(tile.decoration.light_decoration)

func _clear_tree() -> void:
	var children := tree_vbox_container.get_children()
	for child in children:
		child.queue_free()

func get_row_decorations(row_index : int) -> Sequence:
	var notes : Array[Note]
	
	row_index += 1 # excludes the parent node
	
	if row_index < 0 || row_index > tree_height:
		print("Humbug! The row index for get_row_decorations is out of bounds!!!")
		return null
	
	var row_tiles := tree_vbox_container.get_child(row_index).get_children()
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
			var index = event.keycode - 49
			var sequence = get_row_decorations(index)
			var puzzle = puzzle_manager.get_puzzle(index)
			
			$SequencePlayer.play_sequence(sequence)
			
			if puzzle:
				constraints_list.current_puzzle = puzzle
			else:
				print("no puzzle for this row!")
				return

			if puzzle.check_solution(sequence):
				print("solved!!")
			else:
				print("incorrect sequence!!")

func _display_lights() -> void:
	var children := colour_container.get_children()
	for child in children:
		child.queue_free()
	
	var index := 0
	for colour in colour_pitches:
		var light := light_button.instantiate()
		colour_container.add_child(light)
		light.color = colour
		light.index = index
		light.main_tree = self
		index += 1
