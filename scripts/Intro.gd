extends Control


signal timer_start


func _on_ButtonNext_pressed():
	emit_signal("timer_start")
