extends Control

onready var animation_node = $AnimationPlayer as AnimationPlayer

func _ready():
	self.animation_node.play("FadeIn")
	yield(self.get_tree().create_timer(6), "timeout")
	self.animation_node.play("FadeOut")
	yield(self.get_tree().create_timer(3), "timeout")
	GameState.goto_start()
