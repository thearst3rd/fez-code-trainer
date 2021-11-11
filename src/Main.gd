extends Control


const ACTIONS := ["up", "down", "left", "right", "jump", "rotate_left", "rotate_right"]
const ACTION_MAP := ["Up", "Down", "Left", "Right", "A", "LT", "RT"]


func _input(event: InputEvent) -> void:
	for i in range(ACTIONS.size()):
		var action := ACTIONS[i] as String
		if event.is_action_pressed(action):
			print(ACTION_MAP[i])
			get_tree().set_input_as_handled()
			return
