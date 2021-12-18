extends Control


const ACTIONS := ["up", "down", "left", "right", "jump", "rotate_left", "rotate_right"]
const ACTION_MAP := ["Up", "Down", "Left", "Right", "A", "LT", "RT"]

const CODES := [
	["Left", "LT", "Left", "Right", "RT", "Down", "Up", "LT"],
	["Left", "LT", "Right", "RT", "Up", "A", "Down", "RT", "RT"],
]

const MAX_BUTTON_HISTORY_SIZE := 16

var button_history := []


func _process(_delta: float) -> void:
	for i in range(ACTIONS.size()):
		var raw_action := ACTIONS[i] as String
		if Input.is_action_just_pressed(raw_action):
			var action = ACTION_MAP[i]
			print(action)

			if action == "LT":
				play_sound($RotateLeftSound)
			elif action == "RT":
				play_sound($RotateRightSound)

			button_history.push_back(action)
			if button_history.size() > MAX_BUTTON_HISTORY_SIZE:
				button_history.pop_front()

			for ii in range(CODES.size()):
				var code := CODES[ii] as Array
				if entered_code(code):
					print("Entered code %s" % [ii])
					play_sound($CodeEnteredSound)


func entered_code(code: Array) -> bool:
	if button_history.size() < code.size():
		return false
	var offset := button_history.size() - code.size()
	for i in code.size():
		if code[i] != button_history[i + offset]:
			return false
	return true


func play_sound(sound: AudioStreamPlayer):
	var copy = sound.duplicate()
	add_child(copy)
	copy.play()
	yield(copy, "finished")
	copy.queue_free()
