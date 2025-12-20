class_name TreeTile
extends ColorRect

@export var decoration: TreeDecoration
@export var num_label: RichTextLabel

var level_index := 0
var highlighted := false
var main_tree : TreeContainer
var treee : tree
var pressed := false

signal tile_changed

func _ready() -> void:
	color = Color.DARK_GREEN

func _on_mouse_entered() -> void:
	if main_tree.current_level != level_index:
		return
	
	if main_tree.sequence_player.is_playing:
		return
	
	color = Color.SEA_GREEN
	highlighted = true

func _on_mouse_exited() -> void:
	if main_tree.current_level != level_index:
		return
		
	remove_highlight()

func remove_highlight() -> void:
	color = Color.DARK_GREEN
	highlighted = false

func pulse() -> void:
	if main_tree.completed:
		return
	
	var tween := create_tween()
	color = Color.DARK_GREEN.lightened(0.4)
	tween.tween_property(self, "color", Color.DARK_GREEN, 0.3)

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click") || (treee.is_dragging && Input.is_action_just_released("left_click")):
		decoration.set_decoration(Note.new(main_tree.selected_light))
		tile_changed.emit()
	
	if Input.is_action_pressed("right_click"):
		decoration.remove_decoration()
		tile_changed.emit()

func reset_color() -> void:
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "color", Color.DARK_GREEN, 0.5)

func level_change(level: int):
	highlighted = false
	
	if level_index == level:
		color = Color.DARK_GREEN
	else:
		color = Color.DARK_GREEN / 4
