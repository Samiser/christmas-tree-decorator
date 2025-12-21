class_name TreeContainer
extends VBoxContainer

var tree_height: int
var sequence_player: SequencePlayer
var treee : tree

const TREE_TILE = preload("uid://ikpcmbteetwm")
const TREE_ROW = preload("uid://tf7iltka61jk")

signal tile_changed()
signal level_change(level: int)

var is_dragging := false

var puzzle_manager: PuzzleManager
var current_level := -1
var selected_light := -1
var completed = false

func _ready() -> void:
	if not tree_height:
		tree_height = puzzle_manager.puzzle_count() + 1
	_create_tree()

func _create_tree() -> void:
	_clear_tree()
	var level_index := -1
	for row in tree_height:
		var new_row := TREE_ROW.instantiate()
		add_child(new_row)
		
		var tile_index := 0
		for width_index in row * 2:
			var tile: TreeTile = TREE_TILE.instantiate()
			new_row.add_child(tile)
			tile.main_tree = self
			tile.level_index = level_index
			tile.decoration.main_tree = self
			tile.num_label.text = str(level_index + 1) + "_" + str(tile_index + 1)
			tile.tile_changed.connect(tile_changed.emit)
			sequence_player.note_played.connect(tile.decoration.light_decoration)
			tile_index += 1
		
		level_index += 1

func _clear_tree() -> void:
	for child in get_children():
		child.queue_free()
	current_level = -1

func change_level(new_level: int) -> void:
	level_change.emit(current_level)
	for row in get_children():
		for tile in row.get_children():
			tile.level_change(new_level)

func note_played(index: int, note: Note):
	print("i: " + str(index) + ", current_level: " + str(current_level + 1) + ", child_count: " + str(get_child(current_level + 1).get_child_count()))
	var tile: TreeTile = get_child(current_level + 1).get_child(index)
	tile.decoration.light_decoration(index, note)

func tile_checked(index: int):
	var tile: TreeTile = get_child(current_level + 1).get_child(index)
	tile.pulse()

func get_sequence(row: int):
	var notes : Array[Note]
	
	var row_tiles := get_child(row).get_children()
	
	for tile in row_tiles:
		notes.append(tile.decoration.current_note)
	
	var sequence = Sequence.new()
	sequence.length = len(notes)
	for i in len(notes):
		if notes[i] != null:
			sequence.set_note(i, notes[i])
	
	return sequence

func get_current_sequence() -> Sequence:
	return get_sequence(current_level + 1)

func next_level() -> void:
	current_level += 1
	change_level(current_level)

func get_current_puzzle() -> Puzzle:
	return puzzle_manager.get_puzzle(current_level)

func check_sequence() -> void:
	if sequence_player.is_playing:
		return
	
	var sequence = get_current_sequence()
	var puzzle = get_current_puzzle()
	
	for tile in get_child(current_level + 1).get_children():
		tile.remove_highlight()
	
	sequence_player.play_sequence(sequence)
	
	if not puzzle:
		print("no puzzle for this row!")
		return

	if puzzle.check_solution(sequence):
		await sequence_player.playback_finished
		print("solved!!")
		if current_level >= tree_height - 2:
			for row in get_children():
				for tile in row.get_children():
					tile.reset_color()
			await get_tree().create_timer(0.5).timeout
			completed = true
			for i in get_child_count():
				await sequence_player.play_sequence(get_sequence(i))
			print("tree completed!")
			return
		next_level()
	else:
		print("incorrect sequence!!")
