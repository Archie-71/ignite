extends Control

enum states {
	STATE_START
	STATE_SHOW1
	STATE_SHOW2
}

var state = states.STATE_START
var thing1_found = false
var thing2_found = false
var thing1_check = false
var thing2_check = false
var thing1_complete = false
var thing2_complete = false

onready var start = $HintDialog
onready var thing1 = $Thing1Dialog
onready var thing2 = $Thing2Dialog
onready var thing1_sign = $Thing1Sign
onready var thing2_sign = $Thing2Sign
onready var questions = $StageQuestions
onready var answer1 = $StageQuestions/Panel/VBoxContainer/HBoxContainer/LineEdit
onready var answer2 = $StageQuestions/Panel/VBoxContainer/HBoxContainer2/LineEdit

signal next_stage

func _process(_delta):
	if thing1_complete:
		thing1_sign.show()
	else:
		thing1_sign.hide()
	if thing2_complete:
		thing2_sign.show()
	else:
		thing2_sign.hide()
	if state == states.STATE_START:
		start.show()
		thing1.hide()
		thing2.hide()
		if thing1_found:
			state = states.STATE_SHOW1
		elif thing2_found:
			state = states.STATE_SHOW2
		elif thing1_complete && thing2_complete:
			questions.show()
	elif state == states.STATE_SHOW1:
		thing1.show()
		start.hide()
		thing2.hide()
		if thing1_check:
			thing1_complete = true
			thing1_found = false
			thing1_check = false
			state = states.STATE_START
	elif state == states.STATE_SHOW2:
		thing2.show()
		start.hide()
		thing1.hide()
		if thing2_check:
			thing2_complete = true
			thing2_found = false
			thing2_check = false
			state = states.STATE_START
			
func answers_check():
	var answer1_check = (answer1.text.capitalize() == "Wang Huiwu")||(answer1.text == "王会悟")
	var answer2_check = (answer2.text.capitalize() == "The First Resolution")||(answer2.text == "第一个决议")||(answer2.text == "决议")
	return answer1_check && answer2_check


func _on_Thing1Found_pressed():
	thing1_found = true


func _on_Thing2Found_pressed():
	thing2_found = true


func _on_Thing1CheckButton_pressed():
	thing1_check = true


func _on_Thing2CheckButton_pressed():
	thing2_check = true


func _on_ButtonBack_pressed():
	questions.hide()
	thing1_complete = false
	thing2_complete = false


func _on_ButtonNext_pressed():
	if answers_check():
		emit_signal("next_stage")
		questions.hide()
		thing1_complete = false
		thing2_complete = false
	answer1.clear()
	answer2.clear()
