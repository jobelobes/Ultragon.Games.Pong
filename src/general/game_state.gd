extends Node

enum PLAYER_MODES { OnePlayer = 1, TwoPlayer = 2 }

signal player1_goal(score)
signal player2_goal(score)

var _player_count = 1
var _score = [0,0]

func goto_intro():
	self.get_tree().change_scene("res://src/scenes/intro.tscn")
	
func goto_start():
	self.get_tree().change_scene("res://src/scenes/start.tscn")

func goto_game(player_count):
	self._player_count = clamp(player_count, 1, 2)
	self.get_tree().change_scene("res://src/scenes/game_board.tscn")
	
func get_player_count():
	return self._player_count
	
func player1_goal() -> void:
	self._score[0] += 1
	emit_signal("player1_goal", self._score[0])
	
	if self.get_tree().current_scene is GameBoard:
		(self.get_tree().current_scene as GameBoard).reset()
	
func get_player1_score() -> int:
	return self._score[0]

func player2_goal() -> void:
	self._score[1] += 1
	emit_signal("player2_goal", self._score[1])
	
	if self.get_tree().current_scene is GameBoard:
		(self.get_tree().current_scene as GameBoard).reset()
	
func get_player2_score() -> int:
	return self._score[1]
