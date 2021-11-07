extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var system = get_node("/root/System")	
var newPopup
var pause = false
# Called when the node enters the scene tree for the first time.
func _ready():

	get_node("title").text = get_parent().proj.name
	get_node("cred/data").text = get_parent().proj.creds
	get_node("type/data").text = "Project is in " +get_parent().proj.gameState
	get_node("desc").text = "Version "+ get_parent().proj.version +" "+get_parent().proj.gameState
	


func changeProductStage():
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popupCheck.tscn").instance()
		newPopup.connect("submit",self,"setProjStatus")
		newPopup.position.x = 0
		newPopup.name("Which Development Phase is the Project in")
		newPopup.position.y = -50
		newPopup.addItem("Concept")
		newPopup.addItem("Prototype")
		newPopup.addItem("Alpha")
		newPopup.addItem("Beta")
		newPopup.addItem("Release Candidate")
		newPopup.addItem("Release")

		add_child(newPopup)

func setProjStatus():
	get_parent().proj.gameState = newPopup.currentData
	get_node("type/data").text = "Project is in " + newPopup.currentData
	get_node("desc").text = "Version "+ get_parent().proj.version +" "+get_parent().proj.gameState
	saveVersionInfo()
	
func editCreds():
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popupsingle.tscn").instance()
		newPopup.connect("submit",self,"setCreds")
		newPopup.position.x = 0
		newPopup.name("Enter name and Company")
		newPopup.write(get_parent().proj.creds)
		newPopup.position.y = -50
		add_child(newPopup)

func setCreds():
	get_parent().proj.creds = newPopup.currentData
	get_node("cred/data").text = newPopup.currentData 
	saveVersionInfo()

func editVersion():
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popupsingle.tscn").instance()
		newPopup.connect("submit",self,"setVersion")
		newPopup.position.x = 0
		newPopup.name("Enter Version Number")
		newPopup.write(get_parent().proj.version)
		newPopup.position.y = -50
		add_child(newPopup)

func setVersion():
	get_parent().proj.version = newPopup.currentData
	get_node("desc").text = "Version "+ newPopup.currentData +" "+get_parent().proj.gameState
	saveVersionInfo()

func saveVersionInfo():
		system.save.version.num = get_parent().proj.version
		system.save.version.creds = get_parent().proj.creds
		system.save.version.gameState = get_parent().proj.gameState
		system.saveToFile("res://"+system.currentProject+".save")