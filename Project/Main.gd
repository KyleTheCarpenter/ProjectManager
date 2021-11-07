extends Node2D





class Project:
	var name:String
	var size:String
	var desc:String
	var gameState:String
	var creds:String
	var version:String
	

class pauseMenu:

	var info = false
	var versions = false
	var prototype = false



var  system
var proj = Project.new()	
var menuPause = pauseMenu.new()
var newPopup
var newInfo
var pause = false
func _ready():
	system = get_node("/root/System")	
	

	loadInProject()

func filePressed():
	closeTabs()
	get_node("buttons").visible = true




func loadInProject():
	get_node("name").text = system.currentProject
	
	proj.name = system.currentProject
	proj.gameState = system.save.version.gameState
	proj.creds = system.save.version.creds
	proj.desc = system.save.info.desc
	proj.size = system.save.info.size
	proj.version =system.save.version.num

func setProjName():

	system.currentProject = newPopup.currentData
	system.saveProjName()
	system.reload()
	loadInProject()
	pause = false



func loadProjects():
	
	if pause == false:
		pause = true
		newPopup = preload("res://scenes/popupCheck.tscn").instance()
		newPopup.connect("submit",self,"setProjName")
	
		newPopup.name("Select a Project to Work On")
	
		for items in system.projectsArray:
			newPopup.addItem(items)

		add_child(newPopup)


func newProject():
	if pause == false:
		pause = true
		closeTabs()
		newPopup = preload("res://scenes/popupsingle.tscn").instance()

		newPopup.connect("submit",self,"setTitle")
		newPopup.write(proj.name)
		add_child(newPopup)

func setTitle():
	print ("testicl")
	proj.name = newPopup.currentData
	## Saving
	system.currentProject = proj.name
	system.saveProjName()
	system.projectsArray.append(system.currentProject)
	for items in system.projectsArray:
		print(items)
	system.saveNameArray() ##
	print("Saving")
	##
	pause = false
	get_node("name").text = system.currentProject
	system.reload()
	

func loadInfo():
	closeTabs()
	if menuPause.info == false:
		menuPause.info = true
		newInfo = preload("res://scenes/Info.tscn").instance()
		add_child(newInfo)
		newInfo.get_node("shadow").text = proj.name
		newInfo.get_node("title").text = proj.name
		get_node("buttons").visible = false

func openFeatures():
	closeTabs()
	if menuPause.versions == false:
		menuPause.versions = true
		newInfo = preload("res://scenes/FeatureList.tscn").instance()
		add_child(newInfo)
		newInfo.get_node("shadow").text = proj.name
		newInfo.get_node("title").text = proj.name
		get_node("buttons").visible = false


func openVersions():
	closeTabs()
	if menuPause.versions == false:
		menuPause.versions = true
		newInfo = preload("res://scenes/versions.tscn").instance()
		add_child(newInfo)
		newInfo.get_node("shadow").text = proj.name
		newInfo.get_node("title").text = proj.name
		get_node("buttons").visible = false


func openProtoType():
	closeTabs()
	if menuPause.versions == false:
		menuPause.versions = true
		newInfo = preload("res://scenes/ProtoType.tscn").instance()
		add_child(newInfo)
		newInfo.get_node("shadow").text = proj.name
		newInfo.get_node("title").text = proj.name
		get_node("buttons").visible = false


func closeTabs():
	if menuPause.info == true:
		menuPause.info = false
		remove_child(newInfo)
	if menuPause.versions == true:
		menuPause.versions = false
		remove_child(newInfo)

	if menuPause.prototype == true:
		menuPause.prototype = false
		remove_child(newInfo)
