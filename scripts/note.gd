class_name Note
extends Resource

enum Timbre { BELL, LIGHT }

var pitch: int
var timbre: Timbre

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

func _init(p: int, t: Timbre):
	pitch = p
	timbre = t

func get_scale() -> float:
	return pow(2.0, major_scale_map[pitch] / 12.0)
