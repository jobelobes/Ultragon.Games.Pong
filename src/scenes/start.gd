extends Node

func _on_OnePlayerButton_pressed():
	GameState.goto_game(1)

func _on_TwoPlayerButton_pressed():
	GameState.goto_game(2)
