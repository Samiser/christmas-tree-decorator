class_name Note
extends Resource

const COLORS := [Color.RED, Color.BLUE, Color.YELLOW, Color.DEEP_PINK, Color.GREEN, Color.PURPLE, Color.TOMATO, Color.CYAN]
const NAMES := ["C", "D", "E", "F", "G", "A", "B", "C"]
const PITCH_ICONS :Array[Texture2D]= [preload("uid://davdlrfbvs2us"), preload("uid://pqrmjqkpcggh"), preload("uid://cuddw5tbfmyoy"), preload("uid://cjv6jfcbrskfa"), preload("uid://d3bifjjh48nec"), preload("uid://bh2e26uph2vr7"), preload("uid://c0vtbblt4vxex"), preload("uid://cpcrjxkb4l0j0")]

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

func get_icon() -> Texture2D:
	return PITCH_ICONS[pitch] 

func get_pitch_name() -> String:
	return NAMES[pitch % 8]

func get_pitch_text() -> String:
	var color: Color = COLORS[pitch]
	var name: String = get_pitch_name()
	return "[color=%s]%s[/color]" % [color.to_html(), name]

static func pitch_to_text(p: int):
	return Note.new(p).get_pitch_text()
