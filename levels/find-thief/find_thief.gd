extends Level

func _ready() -> void:
	timeout = 5
	%player.found_thief.connect(_win)
	%occlusion_rect.visible = true
	
func _win() -> void:
	win.emit()
