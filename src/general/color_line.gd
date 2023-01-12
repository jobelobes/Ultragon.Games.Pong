tool
extends Control

class_name ColorLine

export var color: Color
export var width: float

func _draw():
	var size = self.get_rect().size
	var start_pos = Vector2(size.x / 2, 0)
	var end_pos = Vector2(size.x / 2, size.y)
	draw_line(start_pos, end_pos, self.color, self.width, false)
