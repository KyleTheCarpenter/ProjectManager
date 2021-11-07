extends Node2D

var desc
var myName : String = ""
var parentsName : String = ""
var newPopup
onready var system = get_node("/root/System")
func setName(s):
	myName = s
	get_node("Button").text = s

func setDesc(s):
	desc = s
	

func setDescs():
	desc = newPopup.currentData
	system.saveFeatureButtonsDesc(parentsName,myName,newPopup.currentData)
	
func clicked():
	newPopup = preload("res://scenes/popup.tscn").instance()
	newPopup.connect("submit",self,"setDescs")
	newPopup.position.x = 0
	newPopup.name("Feature Description")
	newPopup.write(desc)
	newPopup.position.y = -50
	get_parent().get_parent().add_child(newPopup)

func deleteClicked():
	

	get_parent().featureArr.erase(self)

	var temps = ""
	for items in get_parent().featureArr:
		temps+= items.myName + "\n"
	system.saveFeatureButtons(parentsName,temps)


	get_parent().reOrganize()
	get_parent().remove_child(self)
	
