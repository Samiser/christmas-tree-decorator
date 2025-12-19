class_name Note
extends Resource

enum Timbre { BELL, LIGHT }

var pitch: int
var timbre: Timbre

func _init(p: int, t: Timbre):
	pitch = p
	timbre = t

func get_scale() -> float:
	return pow(2.0, pitch / 12.0)
