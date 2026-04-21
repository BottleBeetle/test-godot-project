extends Node

const CONFIG_PATH := "user://config.cfg"

var config := {
	"audio": {
		"music_volume": 0.5,
		"sfx_volume": 1.0
	},
	"video": {
		"fullscreen": true,
		"vsync": true
	},
	"language": "en"
}


func _ready():
	load_config()
	apply_config()


# --- ZAPIS ---
func save_config() -> void:
	var file := FileAccess.open(CONFIG_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(config))
		print("Config saved")


# --- ODCZYT ---
func load_config() -> void:
	if not FileAccess.file_exists(CONFIG_PATH):
		print("No config file found, using defaults")
		return

	var file := FileAccess.open(CONFIG_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())

	if typeof(parsed) == TYPE_DICTIONARY:
		config = parsed
		print("Config loaded")
	else:
		print("Config corrupted, using defaults")


# --- ZASTOSOWANIE USTAWIEŃ ---
func apply_config() -> void:
	# AUDIO
	AudioManager.set_music_volume(config["audio"]["music_volume"])
	AudioManager.set_sfx_volume(config["audio"]["sfx_volume"])

	# VIDEO
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if config["video"]["fullscreen"] else DisplayServer.WINDOW_MODE_WINDOWED
	)

	DisplayServer.window_set_vsync_mode(
		DisplayServer.VSYNC_ENABLED if config["video"]["vsync"] else DisplayServer.VSYNC_DISABLED
	)

	# LANGUAGE
	TranslationServer.set_locale(config["language"])
