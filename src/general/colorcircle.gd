tool
extends Control

class_name ColorCircle

export var color: Color

func _draw():
    draw_circle(Vector2.ZERO, 10, Color.white)