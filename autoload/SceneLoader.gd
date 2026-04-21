extends Node

var is_loading: bool = false

func load_scene(path: String) -> void:
	if is_loading:
		print("Scene is already loading")
		return

	is_loading = true

	# Możesz tu dodać fade-out, animacje, UI itp.
	get_tree().change_scene_to_file(path)

	is_loading = false
