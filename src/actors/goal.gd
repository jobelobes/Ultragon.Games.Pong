extends Area2D

export(NodePath) onready var paddle = get_node(paddle) as Paddle

func _on_body_entered(body:Node):
	if paddle.player_controller == Paddle.PLAYER_CONTROLLER.Player1:
		GameState.player2_goal()
	else:
		GameState.player1_goal()
