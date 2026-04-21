extends Node

signal action_pressed(action: StringName)
signal action_released(action: StringName)

var connected_gamepads: Array = []


func _ready():
	# wykrywanie podłączenia/odłączenia kontrolera
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

	# inicjalne skanowanie
	for id in Input.get_connected_joypads():
		connected_gamepads.append(id)


func _process(delta: float) -> void:
	# lista akcji, które chcesz obsługiwać globalnie
	var actions = [
		"move_left",
		"move_right",
		"jump",
		"attack",
        "pause"
	]

	for action in actions:
		if Input.is_action_just_pressed(action):
			action_pressed.emit(action)

		if Input.is_action_just_released(action):
			action_released.emit(action)


func _on_joy_connection_changed(device_id: int, connected: bool) -> void:
	if connected:
		connected_gamepads.append(device_id)
		print("Gamepad connected: ", device_id)
	else:
		connected_gamepads.erase(device_id)
		print("Gamepad disconnected: ", device_id)
