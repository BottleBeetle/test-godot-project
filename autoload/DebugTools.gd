extends Node

var debug_enabled: bool = true
var overlay_label: Label


func _ready():
	if debug_enabled:
		_create_overlay()


func _process(delta: float) -> void:
	if not debug_enabled:
		return

	if overlay_label:
		overlay_label.text = _generate_overlay_text()


func _create_overlay():
	overlay_label = Label.new()
	overlay_label.set_anchors_preset(Control.PRESET_TOP_LEFT)
	overlay_label.position = Vector2(10, 10)
	overlay_label.add_theme_color_override("font_color", Color(1, 1, 0))
	overlay_label.add_theme_font_size_override("font_size", 14)
	add_child(overlay_label)


func _generate_overlay_text() -> String:
	var fps = Engine.get_frames_per_second()
	var mem = OS.get_static_memory_usage() / 1024 / 1024

	return "FPS: %s\nMemory: %.2f MB" % [fps, mem]


# --- SZYBKIE FUNKCJE DEBUGOWE ---
func teleport_player_to(pos: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.global_position = pos


func add_gold(amount: int) -> void:
	PlayerData.gold += amount
	print("Added gold: ", amount)


func set_hp(value: int) -> void:
	PlayerData.hp = clamp(value, 0, PlayerData.max_hp)
	print("HP set to: ", PlayerData.hp)
