extends Control


signal select_1
signal select_2
signal select_3
signal select_4


func _on_Button1_pressed():
	emit_signal("select_1")


func _on_Button2_pressed():
	emit_signal("select_2")


func _on_Button3_pressed():
	emit_signal("select_3")


func _on_Button4_pressed():
	emit_signal("select_4")
