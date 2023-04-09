extends Control


signal show_settings


func _on_Button_pressed():
	emit_signal("show_settings")
