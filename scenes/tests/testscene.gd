extends Node2D

func _ready():
	print(GameState.is_paused)
	print(GameState.current_level)

	PlayerData.hp = 55
	SaveManager.save_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
