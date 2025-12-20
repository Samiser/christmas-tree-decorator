extends CanvasLayer

@export var tree_container: TreeContainer 
@export var colour_container: HBoxContainer
@export var constraints_list: ConstraintsList
@export var selected_colour: ColorRect
@export var sequence_player: SequencePlayer

const LIGHT_BUTTON = preload("uid://daew471gtbf0p")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_container.level_change.connect(_on_level_change)
	tree_container.tile_changed.connect(_on_tile_changed)
	sequence_player.note_played.connect(tree_container.note_played)
	
	_display_lights()
	_on_color_selected(0)
	tree_container.next_level()

func _on_tile_changed() -> void:
	var puzzle = tree_container.get_current_puzzle()
	var sequence := tree_container.get_current_sequence()
	for i in len(puzzle.constraints):
		constraints_list.set_constraint_complete(i, puzzle.constraints[i].check(sequence))

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			tree_container.check_sequence()

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
