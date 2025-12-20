extends CanvasLayer
class_name tree

var tree_container: TreeContainer

@export var colour_container: HBoxContainer
@export var constraints_list: ConstraintsList
@export var selected_colour: ColorRect
@export var sequence_player: SequencePlayer

@onready var left_container: VBoxContainer = %LeftContainer

@onready var drag_icon: TextureRect = $drag_icon

const LIGHT_BUTTON = preload("uid://daew471gtbf0p")
const TREE_CONTAINER = preload("uid://b7q2tb2n6uhvp")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_container = TREE_CONTAINER.instantiate()
	tree_container.sequence_player = sequence_player
	tree_container.puzzle_manager = PuzzleManager.new(TreeOnePuzzles.get_puzzles())
	tree_container.treee = self
	left_container.add_child(tree_container)
	left_container.move_child(tree_container, 0)
	_set_up_tree_container(tree_container)
	
	sequence_player.note_played.connect(tree_container.note_played)
	sequence_player.tile_checked.connect(tree_container.tile_checked)
	
	_display_lights()
	_on_color_selected(0)
	end_note_drag()

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
				var new := TREE_CONTAINER.instantiate()
				new.puzzle_manager = PuzzleManager.new(TreeTwoPuzzles.get_puzzles())
				new.sequence_player = sequence_player
				_replace_tree_container(new)

func _display_lights() -> void:
	var children := colour_container.get_children()
	for child in children:
		child.queue_free()
	
	var names = ["C", "D", "E", "F", "G", "A", "B", "C"]

	var index := 0
	for colour in Note.COLORS:
		var light: LightButton = LIGHT_BUTTON.instantiate()
		colour_container.add_child(light)
		light.self_modulate = colour
		light.texture = Note.PITCH_ICONS[index]
		light.index = index
		light.color_selected.connect(_on_color_selected)
		light.note_label.text = names[index]
		index += 1

func _on_color_selected(index : int) -> void:
	tree_container.selected_light = index
	var tween := get_tree().create_tween()
	tween.tween_property(selected_colour, "color", Note.COLORS[index], 1.0)
	start_note_drag()

func _on_level_change(_lvl: int) -> void:
	constraints_list.current_puzzle = tree_container.get_current_puzzle()

func start_note_drag() -> void:
	drag_icon.texture = Note.PITCH_ICONS[tree_container.selected_light]
	drag_icon.modulate = Note.COLORS[tree_container.selected_light] / 1.4
	
	drag_icon.visible = true
	tree_container.is_dragging = true

func end_note_drag() -> void:
	if !tree_container.is_dragging:
		return
	
	drag_icon.visible = false
	tree_container.is_dragging = false

func _process(delta: float) -> void:
	pass
	if tree_container.is_dragging:
		drag_icon.set_position(get_viewport().get_mouse_position() + Vector2(-16, -16), true)
		if Input.is_action_just_released("left_click"):
			end_note_drag()
