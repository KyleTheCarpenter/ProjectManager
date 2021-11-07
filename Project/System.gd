extends Node

func n(s):
	return s+"\n"

class infoElement:
	var size : String
	var desc : String

class versionElement:
	var num : String
	var gameState : String
	var creds : String

class saveFile:
	var info = infoElement.new()
	var version = versionElement.new()

# To Load and Save Data into Live Arrays

# ProjectName, info desc, infosize, versionNum, VersionState, Company,featureNames, FeatureData
## Arrays ->

var currentProject = ""
var currentDesc = ""
var projectsArray = []
var infoArray = []
var versionArray = []
var featuresArray = []





var fileName 
var save = saveFile.new()





func _ready():
	loadProjName()
	loadNameArray()
	
	loadInProject()
	loadProjDesc()
	loadFeaturesArray()

func reload():
	featuresArray.clear()
	loadProjName()
	loadNameArray()
	
	loadInProject()
	loadProjDesc()
	loadFeaturesArray()


func loadInProject():
	if currentProject != "":
		loadFromFile("res://.hidden"+currentProject+".save")





func loadFromFile(name):
	fileName = name
	var file = File.new()
	var temp
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		temp = file.get_as_text()
		file.close()
		temp = temp.split("\n")

		#save.info.desc = temp[0]
		save.info.size = temp[1]
		save.version.num = temp[2]
		save.version.gameState = temp[3]
		save.version.creds = temp[4]
		return true
	return false

func saveToFile(name):
	print("Project Saved")
	fileName = name
	var file = File.new()

	var temp = "filler\n"+n(save.info.size)+n(save.version.num)+n(save.version.gameState)+n(save.version.creds)

	file.open(fileName, File.WRITE)
	file.store_line(temp)
	file.close()


func loadProjName():
	fileName = "res://.hiddenProjName.naming"
	var file = File.new()
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		currentProject = file.get_line()
		file.close()
		return
	
func saveProjName():
	fileName = "res://.hiddenProjName.naming"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(currentProject)
	file.close()

func saveNameArray():	
	var file = File.new()
	file.open("res://.hiddenProjNames.ktcIndex", File.WRITE)
	for items in projectsArray:
		if items != "":
			file.store_line(items)
			print("storying " + items)
	file.close()

func loadNameArray():
	fileName = "res://.hiddenProjNames.ktcIndex"
	var file = File.new()
	var tempData = ""
	projectsArray.clear()
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		tempData = file.get_as_text()
		file.close()
		tempData = tempData.split("\n")
		for items in tempData:
			if items != "":
				projectsArray.append(items)
		
		




func saveFeaturesArray():	
	var file = File.new()
	file.open("res://.hidden"+currentProject+"FeatureList.ktcIndex", File.WRITE)
	for items in featuresArray:
		
		file.store_line(items)
	file.close()

func loadFeaturesArray():
	fileName = "res://.hidden"+currentProject+"FeatureList.ktcIndex"
	var file = File.new()
	var tempData = ""

	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		tempData = file.get_as_text()
		file.close()
		tempData = tempData.split("\n")
		for items in tempData:
			if items != "":
				featuresArray.append(items)
		


func loadProjDesc():
	fileName = "res://.hidden"+currentProject+"ProjDesc.desc"
	var file = File.new()
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		save.info.desc = file.get_as_text()
		file.close()
		return
	
func loadProjsDesc(s):
	fileName = "res://.hidden"+s+currentProject+"ProjDesc.desc"
	var file = File.new()
	var temp
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		temp = file.get_as_text()
		file.close()
		return temp
	return ""

func loadProjColor(s):
	fileName = "res://.hidden"+s+currentProject+"color.desc"
	var file = File.new()
	var temp
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		temp = file.get_line()
		file.close()
		return temp
	return ""

func saveProjColor(s,d):
	fileName = "res://.hidden"+s+currentProject+"color.desc"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(d)
	file.close()



func saveProjDesc():
	fileName = "res://.hidden"+currentProject+"ProjDesc.desc"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(save.info.desc)
	file.close()

func saveProjsDesc(s,d):
	fileName = "res://.hidden"+s+currentProject+"ProjDesc.desc"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(d)
	file.close()


func loadFeatureButtons(s):
	fileName = "res://.hidden"+currentProject+s+"features.ktcIndex"
	var file = File.new() 
	var temp
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		temp = file.get_as_text()
		file.close()
		return temp
	return ""
	
func saveFeatureButtons(names,data):
	fileName = "res://.hidden"+currentProject+names+"features.ktcIndex"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(data)
	file.close()


func loadFeatureButtonsDesc(block,itemName):
	fileName = "res://.hidden"+currentProject+block+itemName+"featuresDesc.ktcIndex"
	var file = File.new() 
	var temp
	if file.file_exists(fileName):
		file.open(fileName, File.READ)
		temp = file.get_as_text()
		file.close()
		return temp
	return ""
	
func saveFeatureButtonsDesc(block,itemName,data):
	fileName = "res://.hidden"+currentProject+block+itemName+"featuresDesc.ktcIndex"
	var file = File.new()
	file.open(fileName, File.WRITE)
	file.store_line(data)
	file.close()


	