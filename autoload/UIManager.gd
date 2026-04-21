extends Node

var current_screen: Control = null
var hud: Control = null


func show_screen(scene_path: String) -> void:
	if current_screen:
		current_screen.queue_free()

	var scene = load(scene_path)
	if scene:
		current_screen = scene.instantiate()
		add_child(current_screen)


func show_hud(scene_path: String) -> void:
	if hud:
		hud.queue_free()

	var scene = load(scene_path)
	if scene:
		hud = scene.instantiate()
		add_child(hud)


func hide_screen() -> void:
	if current_screen:
		current_screen.queue_free()
		current_screen = null
