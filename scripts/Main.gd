extends Node

onready var timer = $Timer
onready var title = $Title
onready var title_select = $Title/VBoxContainer/Button6
onready var intro = $Intro
onready var hud = $HUD
onready var hud_time = $HUD/TimerDialog/HBoxContainer/Time
onready var settings = $Settings
onready var settings_return_title = $Settings/IntroBack/Panel/VBoxContainer/Button5
onready var settings_clear_record = $Settings/IntroBack/Panel/VBoxContainer/Button
onready var settings_sound = $Settings/IntroBack/Panel/VBoxContainer/Button3
onready var scoreboard = $Scoreboard
onready var scoreboard_data = $Scoreboard/IntroBack/Panel/VBoxContainer/ScrollContainer/Label
onready var stage1 = $Stage1
onready var stage2 = $Stage2
onready var stage3 = $Stage3
onready var ending = $Ending
onready var ending_name = $Ending/ColorRect2/HBoxContainer/LineEdit
onready var save_button = $Ending/ColorRect2/HBoxContainer/Button
onready var select_stage = $Select
onready var video = $VideoPlayer
onready var bgm = $AudioStreamPlayer

var is_sound = true
var is_select_mode
var time_spent = 0

func _ready():
	var file = File.new()
	if file.file_exists("user://scoreboard.dat"):
		var data = load_scoreboard_data()
		if data != "":
			title_select.show()
		else:
			title_select.hide()
	else:
		title_select.hide()
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	hud_time.text = var2str(time_spent)

func load_scoreboard_data():
	var file = File.new()
	if file.file_exists("user://scoreboard.dat"):
		file.open("user://scoreboard.dat", File.READ)
		var data = file.get_as_text()
		file.close()
		return data
	else:
		file.open("user://scoreboard.dat", File.WRITE)
		file.close()

func save_scoreboard_data(data):
	var file = File.new()
	file.open("user://scoreboard.dat", File.READ_WRITE)
	file.seek_end()
	file.store_line(data)
	file.close()
	
func clear_scoreboard_data():
	var file = File.new()
	file.open("user://scoreboard.dat", File.WRITE)
	file.store_string("")
	file.close()
	
func clean_screen():
	title.hide()
	intro.hide()
	stage1.hide()
	stage2.hide()
	stage3.hide()
	ending.hide()
	hud.hide()
	settings.hide()
	scoreboard.hide()
	select_stage.hide()

func _on_Title_start():
	clean_screen()
	intro.show()

func _on_Title_settings():
	settings_clear_record.show()
	settings_return_title.hide()
	settings.show()

func _on_HUD_show_settings():
	settings_clear_record.hide()
	settings_return_title.show()
	settings.show()
	timer.stop()

func _on_Intro_timer_start():
	clean_screen()
	hud.show()
	stage1.show()
	time_spent = 0
	timer.start()

func _on_Title_score():
	scoreboard_data.text = load_scoreboard_data()
	scoreboard.show()

func _on_Scoreboard_quit_scoreboard():
	scoreboard.hide()

func _on_Settings_credits():
	bgm.stream_paused = true
	video.show()
	video.play()

func _on_Settings_change_sound():
	if bgm.playing:
		bgm.playing = false
		settings_sound.text = "Sound: OFF"
	else:
		bgm.playing = true
		settings_sound.text = "Sound: ON"

func _on_Stage1_next_stage():
	if is_select_mode:
		clean_screen()
		title.show()
		is_select_mode = false
	else:
		clean_screen()
		hud.show()
		stage2.show()

func _on_Stage2_next_stage():
	if is_select_mode:
		clean_screen()
		title.show()
		is_select_mode = false
	else:
		clean_screen()
		hud.show()
		stage3.show()

func _on_Stage3_next_stage():
	if is_select_mode:
		clean_screen()
		title.show()
		is_select_mode = false
	else:
		clean_screen()
		# last scene
		timer.stop()
		ending.show()

func _on_Ending_end():
	clean_screen()
	title.show()

func _on_Ending_save_score():
	if !ending_name.text.empty():
		var datetime = OS.get_datetime()
		var format_time = "%s-%s-%s %s:%s:%s"
		var time_string = format_time % [datetime["year"],datetime["month"],datetime["day"],datetime["hour"],datetime["minute"],datetime["second"]]
		var format_string = "%s: %ds / %s"
		var actual_string = format_string % [ending_name.text, time_spent, time_string]
		save_scoreboard_data(actual_string)
		save_button.set("disabled", true)
		ending_name.clear()
		title_select.show()

func _on_Settings_back():
	settings.hide()
	timer.start()

func _on_Timer_timeout():
	time_spent += 1

func _on_Title_credits():
	bgm.stream_paused = true
	video.show()
	video.play()

func _on_Title_select():
	clean_screen()
	select_stage.show()

func _on_Settings_return_title():
	clean_screen()
	title.show()


func _on_Settings_clean_record():
	clear_scoreboard_data()
	title_select.hide()
	settings.hide()


func _on_Select_select_1():
	clean_screen()
	stage1.show()
	is_select_mode = true


func _on_Select_select_2():
	clean_screen()
	stage2.show()
	is_select_mode = true


func _on_Select_select_3():
	clean_screen()
	stage3.show()
	is_select_mode = true


func _on_Select_select_4():
	clean_screen()
	title.show()


func _on_VideoPlayer_finished():
	video.hide()
	bgm.stream_paused = false
