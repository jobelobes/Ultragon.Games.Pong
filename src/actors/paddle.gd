extends StaticBody2D

class_name Paddle

enum CONTROLLER_TYPE { Player1, Player2, AI, None }

export var speed = 10.0
export(CONTROLLER_TYPE) var controllerType = CONTROLLER_TYPE.None
export(NodePath) onready var ball = get_node(ball) as Ball

onready var sprite_size = $Sprite.get_rect().size

func _physics_process(delta: float):
	var move_amount = 0.0
	match self.controllerType:
		CONTROLLER_TYPE.AI:
			if abs(self.ball.position.x - self.position.x) < 300:
				move_amount = clamp(self.ball.position.y - self.position.y, -speed, speed)
		CONTROLLER_TYPE.Player1:
			if Input.is_action_pressed("player1_move_up"):
				move_amount -= speed
			if Input.is_action_pressed("player1_move_down"):
				move_amount += speed
		CONTROLLER_TYPE.Player2:
			if Input.is_action_pressed("player2_move_up"):
				move_amount -= speed
			if Input.is_action_pressed("player2_move_down"):
				move_amount += speed
				
	var half_height = sprite_size.y / 2.0
	var vp = self.get_viewport_rect().grow_individual(0, -half_height, 0, -half_height)
	self.position.y = clamp(self.position.y + move_amount, vp.position.y, vp.end.y)
