extends Control


signal start
signal score
signal settings
signal credits
signal select


func _on_Button_pressed():
	emit_signal("start")


func _on_Button2_pressed():
	emit_signal("score")


func _on_Button3_pressed():
	emit_signal("settings")


func _on_Button4_pressed():
	emit_signal("credits")


func _on_Button5_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	get_tree().notification(MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST)


func _on_Button6_pressed():
	emit_signal("select")
