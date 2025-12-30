extends Level

const KEYMAP := {
	"W": "move_up",
	"S": "move_down",
	"A": "move_left",
	"D": "move_right",
	" ": "action1",
	"\n": "action2",
}

@onready var _label_text: RichTextLabel = %text

var _text: String
var _idx: int = 0


func _ready() -> void:
	_text = _generate_text(5 + int(10 * difficulty))
	_rebuild_text()


func _input(event: InputEvent) -> void:
	if not _any_action_pressed(event):
		return

	if event.is_action_pressed(KEYMAP[_text[_idx]]):
		_advance()
	else:
		lose.emit()


func _advance() -> void:
	if _idx >= _text.length():
		return

	_idx += 1
	_rebuild_text()

	if _idx >= _text.length():
		win.emit()


func _generate_text(length: int) -> String:
	const CHARS := "WSADWSAD \n"

	var buffer := PackedByteArray()
	buffer.resize(length)
	buffer[0] = ord("WSAD"[randi_range(0, 3)])

	for i in range(1, length):
		buffer[i] = ord(CHARS[randi_range(0, len(CHARS) - 1)])

	return buffer.get_string_from_ascii()


func _any_action_pressed(event: InputEvent) -> bool:
	for action in KEYMAP.values():
		if event.is_action_pressed(action):
			return true
	return false


func _rebuild_text() -> void:
	_label_text.clear()
	_label_text.push_color(Color.GREEN_YELLOW)
	_label_text.add_text(_text.substr(0, _idx))
	_label_text.pop()

	if _idx < _text.length():
		_label_text.push_font_size(40)
		_label_text.push_underline(Color.WHITE)

		if _text[_idx] == "\n":
			_label_text.add_text("<Enter>\n")
		else:
			_label_text.add_text(_text[_idx])

		_label_text.pop()
		_label_text.pop()

		_label_text.add_text(_text.substr(_idx + 1))
