extends CanvasLayer
class_name tree

var colour_pitches := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]

var selected_light := 0
var current_level := -1

@export var tree_vbox_container: VBoxContainer 
@export var colour_container: HBoxContainer
@export var constraints_list: ConstraintsList
@export var selected_colour: ColorRect
@export var sequence_player: SequencePlayer

@export var tree_height = 7;
@export var tree_tile : PackedScene
@export var tree_row : PackedScene
@export var light_button : PackedScene
signal level_change(level: int)

var puzzle_manager: PuzzleManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_display_lights()
	_create_tree()
	puzzle_manager = PuzzleManager.new()
	select_colour(0)
	next_level()

func _create_tree() -> void:
	_clear_tree()
	var level_index := -1
	for row in tree_height:
		var new_row := tree_row.instantiate()
		tree_vbox_container.add_child(new_row)
		
		var tile_index := 0
		for width_index in row * 2:
			var tile: TreeTile = tree_tile.instantiate()
			new_row.add_child(tile)
			tile.main_tree = self
			tile.level_index = level_index
			tile.decoration.main_tree = self
			tile.num_label.text = str(level_index + 1) + "_" + str(tile_index + 1)
			tile.tile_changed.connect(_on_tile_changed)
			level_change.connect(tile.level_change)
			$SequencePlayer.note_played.connect(tile.decoration.light_decoration)
			tile_index += 1
		
		level_index += 1

func _on_tile_changed() -> void:
	var puzzle = puzzle_manager.get_puzzle(current_level)
	for i in len(puzzle.constraints):
		var sequence := get_row_decorations(current_level)
		constraints_list.set_constraint_complete(i, puzzle.constraints[i].check(sequence))

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
		if event.keycode == KEY_SPACE:
			if sequence_player.is_playing:
				return
			
			var sequence = get_row_decorations(current_level)
			var puzzle = puzzle_manager.get_puzzle(current_level)
			
			$SequencePlayer.play_sequence(sequence)
			
			if not puzzle:
				print("no puzzle for this row!")
				return

			if puzzle.check_solution(sequence):
				print("solved!!")
				await sequence_player.playback_finished
				next_level() 
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
		light.note_label.text = str(index)
		index += 1

func select_colour(index : int) -> void:
	selected_light = index
	var tween := get_tree().create_tween()
	tween.tween_property(selected_colour, "color", colour_pitches[index], 1.0)

func next_level() -> void:
	current_level += 1
	constraints_list.current_puzzle = puzzle_manager.get_puzzle(current_level)
	level_change.emit(current_level)
	print(current_level)
