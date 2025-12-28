extends Control

@export var transition_time : float = 1

signal transition_done

func transition() -> void:
	visible = true
	var transition_step_time = transition_time / 4.0
	"""
	after step 1, display ready
	step 2, set
	step 3, go
	step 4 we are done
	"""
	%readyTimer.start(transition_step_time * 1)
	%setTimer.start(transition_step_time * 2)
	%goTimer.start(transition_step_time * 3)
	%doneTimer.start(transition_time)

func _on_ready_timer_timeout() -> void:
	$CenterContainer/VBoxContainer/ready.visible = true

func _on_set_timer_timeout() -> void:
	$CenterContainer/VBoxContainer/set.visible = true

func _on_go_timer_timeout() -> void:
	$CenterContainer/VBoxContainer/go.visible = true

func _on_done_timer_timeout() -> void:
	$CenterContainer/VBoxContainer/ready.visible = false
	$CenterContainer/VBoxContainer/set.visible = false
	$CenterContainer/VBoxContainer/go.visible = false
	visible = false
	transition_done.emit()
