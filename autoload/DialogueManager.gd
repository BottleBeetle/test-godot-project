extends Node

signal dialogue_started(id: String)
signal dialogue_ended(id: String)
signal line_changed(text: String)

var current_dialogue: Array = []
var index: int = 0
var active: bool = false


func start_dialogue(lines: Array, id := "dialogue") -> void:
	current_dialogue = lines
	index = 0
	active = true

	dialogue_started.emit(id)
	_emit_current_line()


func next_line() -> void:
	if not active:
		return

	index += 1

	if index >= current_dialogue.size():
		end_dialogue()
		return

	_emit_current_line()


func _emit_current_line():
	line_changed.emit(current_dialogue[index])


func end_dialogue(id := "dialogue") -> void:
	active = false
	dialogue_ended.emit(id)
