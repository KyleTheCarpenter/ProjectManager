extends Node2D


var pause = true
var currentAnime = ""
var currentData : String
signal submit
func _ready():
	print("ConsoleTest")
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
		
		##
		emit_signal("submit")
		get_parent().pause = false
		get_parent().remove_child(self)
		
func anyItemSelected(index):
		currentData = get_node("main/items").get_item_text(index)		
		

func name(s):
	get_node("main/title").text = s

func addItem(s):
	get_node("main/items").add_item(s,null,true)

func pickOld():
	pass
	