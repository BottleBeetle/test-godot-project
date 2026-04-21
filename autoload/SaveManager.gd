extends Node

const SAVE_DIR := "user://saves/"
const SLOT_COUNT := 3

func _ready():
	# Tworzymy folder na save’y jeśli nie istnieje
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_recursive_absolute(SAVE_DIR)


func get_slot_path(slot: int) -> String:
	return SAVE_DIR + "slot_%d.json" % slot


func save_game(slot: int) -> void:
	var data: Dictionary = {
		"timestamp": Time.get_datetime_string_from_system(),
		"hp": PlayerData.hp,
		"max_hp": PlayerData.max_hp,
		"xp": PlayerData.xp,
		"level": PlayerData.level,
		"gold": PlayerData.gold,
		"inventory": PlayerData.inventory,
		"quests_completed": PlayerData.quests_completed,
		"settings": PlayerData.settings
	}

	var path := get_slot_path(slot)
	var file := FileAccess.open(path, FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(data))
		print("Saved to slot ", slot, " at ", path)


func load_game(slot: int) -> void:
	var path := get_slot_path(slot)

	if not FileAccess.file_exists(path):
		print("Slot ", slot, " is empty")
		return

	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		print("Failed to open slot ", slot)
		return

	var parsed = JSON.parse_string(file.get_as_text())

	if typeof(parsed) != TYPE_DICTIONARY:
		print("Save file corrupted in slot ", slot)
		return

	var data: Dictionary = parsed

	PlayerData.hp = data.get("hp", PlayerData.hp)
	PlayerData.max_hp = data.get("max_hp", PlayerData.max_hp)
	PlayerData.xp = data.get("xp", PlayerData.xp)
	PlayerData.level = data.get("level", PlayerData.level)
	PlayerData.gold = data.get("gold", PlayerData.gold)
	PlayerData.inventory = data.get("inventory", [])
	PlayerData.quests_completed = data.get("quests_completed", [])
	PlayerData.settings = data.get("settings", PlayerData.settings)

	print("Loaded slot ", slot)


func delete_slot(slot: int) -> void:
	var path := get_slot_path(slot)
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
		print("Deleted slot ", slot)


func get_slot_metadata(slot: int) -> Dictionary:
	var path := get_slot_path(slot)

	if not FileAccess.file_exists(path):
		return {}

	var file := FileAccess.open(path, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())

	if typeof(parsed) != TYPE_DICTIONARY:
		return {}

	return {
		"timestamp": parsed.get("timestamp", "unknown"),
		"level": parsed.get("level", 1),
		"hp": parsed.get("hp", 0)
	}
