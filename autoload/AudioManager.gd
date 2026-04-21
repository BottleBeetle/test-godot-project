extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready():
	# Tworzymy dwa odtwarzacze: muzyka + SFX
	music_player = AudioStreamPlayer.new()
	sfx_player = AudioStreamPlayer.new()

	add_child(music_player)
	add_child(sfx_player)

	# Ustawiamy głośność z PlayerData.settings
	music_player.volume_db = linear_to_db(PlayerData.settings["music_volume"])
	sfx_player.volume_db = linear_to_db(PlayerData.settings["sfx_volume"])


# --- MUZYKA ---
func play_music(stream: AudioStream) -> void:
	if music_player.stream == stream:
		return  # już gra ta sama muzyka

	music_player.stream = stream
	music_player.play()


func stop_music() -> void:
	music_player.stop()


# --- EFEKTY DŹWIĘKOWE ---
func play_sfx(stream: AudioStream) -> void:
	sfx_player.stream = stream
	sfx_player.play()


# --- GŁOŚNOŚĆ ---
func set_music_volume(value: float) -> void:
	PlayerData.settings["music_volume"] = value
	music_player.volume_db = linear_to_db(value)


func set_sfx_volume(value: float) -> void:
	PlayerData.settings["sfx_volume"] = value
	sfx_player.volume_db = linear_to_db(value)
