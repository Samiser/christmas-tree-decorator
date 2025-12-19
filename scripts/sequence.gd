class_name Sequence
extends Resource

enum Timbre { BELL, LIGHT }

class Note:
	var pitch: int
	var timbre: Timbre
	
	func _init(p: int, t: Timbre):
		pitch = p
		timbre = t

var notes: Dictionary[int, Note] = {}
var length: int = 0

func set_note(index: int, pitch: int, timbre: Timbre) -> void:
	if index < length:
		notes[index] = Note.new(pitch, timbre)

func clear_note(index: int) -> void:
	notes.erase(index)

func compare(other: Sequence) -> bool:
	if length != other.length:
		return false
	if notes.size() != other.notes.size():
		return false
	for index in notes.keys():
		if not other.notes.has(index):
			return false
		if notes[index].pitch != other.notes[index].pitch:
			return false
		if notes[index].timbre != other.notes[index].timbre:
			return false
	return true
