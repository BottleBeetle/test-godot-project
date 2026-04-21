extends Node

# --- Podstawowe statystyki ---
var hp: int = 100
var max_hp: int = 100

var xp: int = 0
var level: int = 1

# --- Waluta / punkty ---
var gold: int = 0

# --- Ekwipunek ---
var inventory: Array = []

# --- Questy / progres ---
var quests_completed: Array = []

# --- Ustawienia gracza ---
var settings := {
	"music_volume": 0.5,
	"sfx_volume": 1.0,
	"language": "en"
}

# --- Reset danych (np. przy nowej grze) ---
func reset():
	hp = max_hp
	xp = 0
	level = 1
	gold = 0
	inventory.clear()
	quests_completed.clear()
