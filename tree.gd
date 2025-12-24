extends CanvasLayer
class_name tree

var tree_container: TreeContainer

@export var colour_container: HBoxContainer
@export var constraints_list: ConstraintsList
@export var sequence_player: SequencePlayer

@onready var left_container: VBoxContainer = %LeftContainer
@onready var background: Background = $Background
@onready var drag_icon: TextureRect = $drag_icon
@onready var the_end: Sprite2D = $TheEnd

@onready var tutorial_1: Control = $Tutorial1
@onready var tutorial_2: Control = $Tutorial2

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
	
	_display_lights()
	_on_color_selected(0)
	end_note_drag()

func _set_up_tree_container(container: TreeContainer) -> void:
	sequence_player.note_played.connect(container.note_played)
	sequence_player.tile_checked.connect(container.tile_checked)
	
	container.level_change.connect(_on_level_change)
	container.tile_changed.connect(_on_tile_changed)
	container.next_level()

func _replace_tree_container(new_tree: TreeContainer) -> void:
	var old_tree := tree_container
	tree_container = new_tree
	old_tree.queue_free()
	
	
	left_container.add_child(new_tree)
	left_container.move_child(new_tree, 0)
	_set_up_tree_container(new_tree)

func _on_tile_changed() -> void:
	var puzzle = tree_container.get_current_puzzle()
	var sequence := tree_container.get_current_sequence()
	for i in len(puzzle.constraints):
		constraints_list.set_constraint_complete(i, puzzle.constraints[i].check(sequence))

func _advance_tutorial() -> void:
	if tutorial_1.visible and tutorial_2.visible:
		tutorial_2.hide()
	elif tutorial_1.visible:
		tutorial_1.hide()
		tutorial_2.show()
	elif tutorial_2.visible:
		tutorial_2.hide()

func _end() -> void:
	var tween := create_tween()
	tween.tween_property(the_end, "modulate:a", 1.0, 5.0)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			if tree_container.completed and tree_container.puzzle_manager.puzzle_count() == len(TreeThreePuzzles.get_puzzles()):
				return
			await tree_container.check_sequence()
			if tree_container.completed:
				colour_container.hide()
				constraints_list.hide()
				await tree_container.play_tree()
				var new := TREE_CONTAINER.instantiate()
				if tree_container.puzzle_manager.puzzle_count() == len(TreeOnePuzzles.get_puzzles()):
					new.puzzle_manager = PuzzleManager.new(TreeTwoPuzzles.get_puzzles())
				elif tree_container.puzzle_manager.puzzle_count() == len(TreeTwoPuzzles.get_puzzles()):
					for button in colour_container.get_children():
						button.hide_label()
					new.puzzle_manager = PuzzleManager.new(TreeThreePuzzles.get_puzzles())
				else:
					_end()
					print("victory!!")
					return
				colour_container.show()
				constraints_list.show()
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
		light.self_modulate = colour
		light.texture = Note.PITCH_ICONS[index]
		light.index = index
		light.color_selected.connect(_on_color_selected)
		light.note_label.text = Note.NAMES[index]
		index += 1

func _on_color_selected(index : int) -> void:
	tree_container.selected_light = index
	background.change_color(Note.COLORS[index])
	start_note_drag()

func _on_level_change(_lvl: int) -> void:
	constraints_list.current_puzzle = tree_container.get_current_puzzle()
	if tutorial_1.visible or tutorial_2.visible:
		_advance_tutorial()

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

func _process(_delta: float) -> void:
	if tree_container.is_dragging:
		drag_icon.set_position(get_viewport().get_mouse_position() + Vector2(-16, -16), true)
		if Input.is_action_just_released("left_click"):
			end_note_drag()
