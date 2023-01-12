extends Node2D

class_name GameBoard

onready var _ball = $Ball as Ball
onready var _player1 = $Player1 as Paddle
onready var _player2 = $Player2 as Paddle
onready var _player1_score = $CanvasLayer/HBoxContainer/Player1_Score as Label
onready var _player2_score = $CanvasLayer/HBoxContainer/Player2_Score as Label

func _ready():
	GameState.connect("player1_goal", self, "_on_player1_goal")
	GameState.connect("player2_goal", self, "_on_player2_goal")
	
	self._player1_score.text = "0"
	self._player2_score.text = "0"
	
	if GameState.get_player_count() == 2:
		self._player2.player_controller = Paddle.PLAYER_CONTROLLER.Player2
	else:
		self._player2.player_controller = Paddle.PLAYER_CONTROLLER.AI
		
	self.reset()
	
func _on_player1_goal(score):
	self._player1_score.text = str(score)
	
func _on_player2_goal(score):
	self._player2_score.text = str(score)
	
func reset():
	self._ball.reset()
