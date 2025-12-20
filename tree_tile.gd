class_name TreeTile
extends ColorRect

@export var decoration: ColorRect
@export var num_label: RichTextLabel

var level_index := 0
var highlighted := false
var main_tree : tree

signal tile_changed

func _ready() -> void:
	color = Color.DARK_GREEN

func _on_mouse_entered() -> void:
	if main_tree.current_level != level_index:
		return
	
	color = Color.SEA_GREEN
	highlighted = true

func _on_mouse_exited() -> void:
	if main_tree.current_level != level_index:
		return
		
	color = Color.DARK_GREEN
	highlighted = false

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click"):
		$decoration.set_decoration(Note.new(main_tree.selected_light, 0))
		tile_changed.emit()
	
	if Input.is_action_pressed("right_click"):
		$decoration.remove_decoration()
		tile_changed.emit()

func level_change(level: int):
	highlighted = false
	
	if level_index == level:
		color = Color.DARK_GREEN
	else:
		color = Color.DARK_GREEN / 4
