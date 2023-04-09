extends Control


signal end
signal save_score


func _on_Button_pressed():
	emit_signal("save_score")


func _on_ButtonEnd_pressed():
	emit_signal("end")
