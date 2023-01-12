extends StaticBody2D

class_name Paddle

enum PLAYER_CONTROLLER { Player1, Player2, AI }

export var speed = 500.0
export(NodePath) onready var ball = get_node(ball) as Ball
export(PLAYER_CONTROLLER) var player_controller: int = PLAYER_CONTROLLER.Player1

onready var _half_height = $Sprite.get_rect().size.y / 2.0
var _ai_state = {}

func _physics_process(delta: float):
	match player_controller:
		PLAYER_CONTROLLER.Player1:
			self.position.y += _player_move(true, delta)
		PLAYER_CONTROLLER.Player2:
			self.position.y += _player_move(false, delta)
		PLAYER_CONTROLLER.AI:
			self.position.y += _ai_move(delta)
	self._maintain_bounds()
	
func _player_move(is_player_one: bool, delta: float) -> float:
	if Input.is_action_pressed("player1_move_up" if is_player_one else "player2_move_up"):
		return -speed * delta
	elif Input.is_action_pressed("player1_move_down" if is_player_one else "player2_move_down"):
		return speed * delta
	else:
		return 0.0

func _ai_move(delta: float):
	if self._ai_state.get("last_pos") == null:
		self._ai_state["last_pos"] = self.ball.position
		return 0.0
	
	# update state
	var last_position = self._ai_state["last_pos"]
	self._ai_state["last_pos"] = self.ball.position
	
	var ball_velocity = (self.ball.position - last_position) / delta
	if ball_velocity.x <= 0: # ball moving away, sleep!
		return 0.0
		
	var impact_time = abs(self.ball.position.x - self.position.x) / ball_velocity.x
	var impact_pos_y = self.ball.position.y + (ball_velocity.y * impact_time)

	# don't want the paddle jerking around
	if (abs(impact_pos_y - self.position.y) < 10):
		return 0.0

	if (impact_pos_y < self.position.y):
		return -speed * delta
	else:
		return speed * delta

func _maintain_bounds():
	var vp = self.get_viewport_rect().grow_individual(0, -_half_height, 0, -_half_height)
	self.position.y = clamp(self.position.y, vp.position.y, vp.end.y)
