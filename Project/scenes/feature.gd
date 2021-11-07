extends Node2D


var posY = 10
var size = 1
var side 
var id : int
var featureCount = 0
var featureArr = []
var snewPopup
var pause = false
var myName : String
var myDesc : String
var myColor : String
onready var system = get_node("/root/System")
func _ready():
	loadButtonsIndex()
	myDesc = system.loadProjsDesc(myName)
	myColor = system.loadProjColor(myName)
	setTheColor() 
	var tc = 0
	for items in featureCount:
		if tc > 3:
			size+= 0.35
			tc+=1
			print("wed")
	fixBg()
		

func deleteFeatureBox():
	print("clicked")
	for items in system.featuresArray:
		print("Checking " + items)
		if items == myName:
			system.featuresArray.erase(items)
			system.saveFeaturesArray()
			print("deleted")
	get_parent().featureBlocks.erase(self)
	for items in get_parent().featureBlocks:
		if items.side == side && items.id > id:
			items.position.y-=260
	get_parent().remove_child(self)



var tempSize = 0
func addFeature(sName,sDesc):
	featureCount+=1
	if featureCount > 4:
		size+=0.15
		get_node("bg").scale.y=size
		if side =="Left":
			get_parent().leftHeight+=1
		if side == "Right":
			get_parent().rightHeight+=1
		
	var newPopup = preload("res://scenes/featureButton.tscn").instance()
	#newPopup.connect("submit",self,"setDesc")
	newPopup.position.x = 0
	newPopup.parentsName = myName
	newPopup.setName(sName)
	newPopup.setDesc(sDesc)
	newPopup.position.y = posY
	posY+=30
	featureArr.append(newPopup)
	add_child(newPopup)

func fixBg():
	get_node("bg").scale.y=size

func reOrganize():
	posY = 10
	for items in featureArr:
		items.position.y = posY
		posY+=30


func addNewFeature():
	snewPopup = preload("res://scenes/popupsingle.tscn").instance()
	snewPopup.connect("submit",self,"setFeatureName")
	snewPopup.position.x = 0
	snewPopup.name("Feature Name")
	snewPopup.position.y = -50
	get_parent().add_child(snewPopup)
	

func setFeatureName():
	

	addFeature(snewPopup.currentData,"Add a description")
	saveButtonsIndex()
	if featureCount > 5:
		get_parent().reOrganize()


func setName(s):
	myName = s
	get_node("Label").text = s
	
func saveButtonsIndex():
	var temp = ""
	for item in featureArr:
		temp+= item.myName+"\n"

	system.saveFeatureButtons(myName,temp)

func loadButtonsIndex():
	var temp = system.loadFeatureButtons(myName)
	temp = temp.split("\n")
	for items in temp:
		if items != "":
			addFeature(items,system.loadFeatureButtonsDesc(myName,items))

		if featureCount > 5:
			get_parent().reOrganize()


func addDescToFeature():
	
	if pause == false:
		
		snewPopup = preload("res://scenes/popup.tscn").instance()
		snewPopup.connect("submit",self,"setDesc")
		snewPopup.position.x = 0
		snewPopup.name("Edit Description")
		snewPopup.write(myDesc)
		snewPopup.position.y = -50
		get_parent().add_child(snewPopup)


func setDesc():
	myDesc = snewPopup.currentData
	system.saveProjsDesc(myName,myDesc)

	pause = false

func changeColor():
	if get_parent().pause == false:
		get_parent().pause = true
		snewPopup = preload("res://scenes/popupCheck.tscn").instance()
		snewPopup.connect("submit",self,"setColor")
		snewPopup.position.x = 0
		snewPopup.name("Pick a Color")
		snewPopup.position.y = -50
		snewPopup.addItem("Gray")
		snewPopup.addItem("Blue")
		snewPopup.addItem("Red")
		snewPopup.addItem("Orange")
		snewPopup.addItem("Green")

		get_parent().add_child(snewPopup)

func setColor():
	get_parent().pause = false
	myColor = snewPopup.currentData
	system.saveProjColor(myName,myColor)
	setTheColor()

func setTheColor():
	match myColor:
		"" : 
			get_node("bg/color").color = Color(0.75, 0.75, 0.75, 0.4)
		"Gray" :
			get_node("bg/color").color = Color(0.75, 0.75, 0.75, 0.4)
		"Blue" :
			get_node("bg/color").color = Color(0, 0, 1, 0.4)
		"Red" :
			get_node("bg/color").color = Color(1, 0, 0, 0.4)
		"Orange" :
			get_node("bg/color").color = Color(1, 0.65, 0, 0.4)
		"Green" :
			get_node("bg/color").color = Color(0, 1, 0, 0.4)
		
	
	