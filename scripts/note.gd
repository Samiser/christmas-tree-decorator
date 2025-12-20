class_name Note
extends Resource

const COLORS := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]

var pitch: int

var major_scale_map: Dictionary[int, int] = {
	0: 0,
	1: 2,
	2: 4,
	3: 5,
	4: 7,
	5: 9,
	6: 11,
	7: 12,
}

func _init(p: int):
	pitch = p

func get_scale() -> float:
	return pow(2.0, major_scale_map[pitch] / 12.0)

func get_color() -> Color:
	return COLORS[pitch]

func get_pitch_name() -> String:
	var names = ["C", "D", "E", "F", "G", "A", "B", "C"]
	return names[pitch % 8]

func get_pitch_text() -> String:
	var color: Color = COLORS[pitch]
	var name: String = get_pitch_name()
	return "[color=%s]%s[/color]" % [color.to_html(), name]

static func pitch_to_text(p: int):
	print(Note.new(p).get_pitch_text())
	return Note.new(p).get_pitch_text()
