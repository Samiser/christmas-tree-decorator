extends CanvasLayer

var tree_container: TreeContainer

@export var colour_container: HBoxContainer
@export var constraints_list: ConstraintsList
@export var selected_colour: ColorRect
@export var sequence_player: SequencePlayer

@onready var left_container: VBoxContainer = %LeftContainer

const LIGHT_BUTTON = preload("uid://daew471gtbf0p")
const TREE_CONTAINER = preload("uid://b7q2tb2n6uhvp")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_container = TREE_CONTAINER.instantiate()
	tree_container.tree_height = 5
	tree_container.sequence_player = sequence_player
	left_container.add_child(tree_container)
	left_container.move_child(tree_container, 0)
	_set_up_tree_container(tree_container)
	
	sequence_player.note_played.connect(tree_container.note_played)
	sequence_player.tile_checked.connect(tree_container.tile_checked)
	
	_display_lights()
	_on_color_selected(0)

func _set_up_tree_container(container: TreeContainer) -> void:
	container.level_change.connect(_on_level_change)
	container.tile_changed.connect(_on_tile_changed)
	container.next_level()

func _replace_tree_container(new_tree: TreeContainer) -> void:
	var old_tree := tree_container
	tree_container = new_tree
	left_container.remove_child(old_tree)
	left_container.add_child(new_tree)
	left_container.move_child(new_tree, 0)
	_set_up_tree_container(new_tree)

func _on_tile_changed() -> void:
	var puzzle = tree_container.get_current_puzzle()
	var sequence := tree_container.get_current_sequence()
	for i in len(puzzle.constraints):
		constraints_list.set_constraint_complete(i, puzzle.constraints[i].check(sequence))

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			await tree_container.check_sequence()
			if tree_container.completed:
				print("here")
				var new := TREE_CONTAINER.instantiate()
				new.tree_height = 7
				new.sequence_player = sequence_player
				_replace_tree_container(new)

func _display_lights() -> void:
	var children := colour_container.get_children()
	for child in children:
		child.queue_free()
	
	var index := 0
	for colour in Note.COLORS:
		var light: LightButton = LIGHT_BUTTON.instantiate()
		colour_container.add_child(light)
		light.color = colour
		light.index = index
		light.color_selected.connect(_on_color_selected)
		light.note_label.text = str(index)
		index += 1

func _on_color_selected(index : int) -> void:
	tree_container.selected_light = index
	var tween := get_tree().create_tween()
	tween.tween_property(selected_colour, "color", Note.COLORS[index], 1.0)

func _on_level_change(_lvl: int) -> void:
	constraints_list.current_puzzle = tree_container.get_current_puzzle()
