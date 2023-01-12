extends Node

onready var winner_label = $VBoxContainer/MarginContainer/Label as Label

func _ready():
	if GameState.get_player1_score() > GameState.get_player2_score():
		self.winner_label.text = "Player 1 Wins"
	else:
		self.winner_label.text = "Player 2 Wins"

func _on_ReturnButton_pressed():
	GameState.goto_start()
