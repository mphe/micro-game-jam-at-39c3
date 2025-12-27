class_name Level
extends Node

signal win
signal lose

## Timer for the current level. On timeout, the player loses
@export var timeout: float = 10
## Difficulty is a value between 0.1 and 0.9. It is automatically set as part of a difficulty curve. You may include this value in your gameplay, but are not required to.
@export_range(0.1, 0.9) var difficulty: float =  0.1

func _ready() -> void:
	get_tree().create_timer(timeout).timeout.connect(_on_timeout)

func _on_timeout() -> void:
	lose.emit()
	queue_free()
