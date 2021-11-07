extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var newPopup
var pause = false
var system
# Called when the node enters the scene tree for the first time.
func _ready():
	system = get_node("/root/System")
	get_node("title").text = get_parent().proj.name
	get_node("size/data").text = get_parent().proj.size
	get_node("desc").text = get_parent().proj.desc
	

func editDescription():
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popup.tscn").instance()
		newPopup.connect("submit",self,"setDesc")
		newPopup.position.x = 0
		newPopup.name("Edit Description")
		newPopup.write(get_parent().proj.desc)
		newPopup.position.y = -50
		add_child(newPopup)


func setDesc():
	get_parent().proj.desc = newPopup.currentData
	get_node("desc").text = newPopup.currentData
	system.save.info.desc = newPopup.currentData
	system.saveProjDesc()


func editSize():
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popupsingle.tscn").instance()
		newPopup.connect("submit",self,"setSize")
		newPopup.position.x = 0
		newPopup.name("Edit Target and Size")
		newPopup.write(get_parent().proj.size)
		newPopup.position.y = -50
		add_child(newPopup)


func setSize():
	get_parent().proj.size = newPopup.currentData
	get_node("size/data").text = newPopup.currentData
	saveInfo()



func saveInfo():
	system.save.info.desc = get_parent().proj.desc
	system.save.info.size = get_parent().proj.size
	system.saveToFile("res://"+system.currentProject+".save")