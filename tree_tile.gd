extends ColorRect

@onready var decoration: ColorRect = $decoration
var level_index := 0
var highlighted := false
var main_tree : tree

func _ready() -> void:
	color = Color.DARK_GREEN

func _on_mouse_entered() -> void:
	if main_tree.current_level != level_index:
		highlighted = false
		return
	
	color = Color.GREEN
	highlighted = true

func _on_mouse_exited() -> void:
	color = Color.DARK_GREEN
	highlighted = false

func _input(_event):
	if !highlighted:
		return

	if Input.is_action_just_pressed("left_click"):
		$decoration.set_decoration(Note.new(main_tree.selected_light, 0))
	
	if Input.is_action_pressed("right_click"):
		$decoration.remove_decoration()
