extends Node

signal quest_started(id: String)
signal quest_completed(id: String)

var active_quests: Dictionary = {}
var completed_quests: Array = []


func start_quest(id: String, data := {}) -> void:
	if active_quests.has(id):
		return

	active_quests[id] = data
	quest_started.emit(id)


func complete_quest(id: String) -> void:
	if not active_quests.has(id):
		return

	active_quests.erase(id)
	completed_quests.append(id)
	quest_completed.emit(id)
