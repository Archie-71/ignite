extends Control


signal back
signal change_sound
signal credits
signal return_title
signal clean_record


func _on_Button2_pressed():
	emit_signal("back")


func _on_Button3_pressed():
	emit_signal("change_sound")


func _on_Button4_pressed():
	emit_signal("credits")


func _on_Button5_pressed():
	emit_signal("return_title")


func _on_Button_pressed():
	emit_signal("clean_record")
