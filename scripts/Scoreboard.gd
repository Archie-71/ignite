extends Control


signal quit_scoreboard


func _on_ButtonNext_pressed():
	emit_signal("quit_scoreboard")
