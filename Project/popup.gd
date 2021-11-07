extends Node2D


var pause = true
var currentAnime = ""
var currentData
var blockedLetters = ["/","\\","."]
signal submit
func _ready():
	
	loadAnime()



func exitAnime():
	pauseGame()
	get_node("AnimationPlayer").play("close")
	currentAnime = "close"

func submitPressed():
	pauseGame()
	get_node("AnimationPlayer").play("submit")
	currentAnime = "submit"

func loadAnime():
	get_node("AnimationPlayer").play("load")
	

func pauseGame():
	pause = true
	get_node("Timer").start()

func timerDone():
	get_node("Timer").stop()
	pause = false
	if currentAnime == "close":
		get_parent().pause = false
		get_parent().remove_child(self)
	elif currentAnime == "submit":
		##
		currentData = get_node("main/data").text
		##
		emit_signal("submit")
		get_parent().pause = false
		get_parent().remove_child(self)
		
		


	#################################

func name(s):
	get_node("main/title").text = s

func write(s):
	get_node("main/data").text = s

func checkForChars(new_text:String):
	for items in new_text:
		for blocked in blockedLetters:

			if items == blocked:
				get_node("main/data").delete_char_at_cursor()
