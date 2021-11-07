extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var posX = "Left"
var posY = -220
onready var system = get_node("/root/System")
var leftHeight = 0
var rightHeight = 0
var snewPopup
var pause = false
var featureBlocks = []
var savedScroll = 0

class featureBlock:
	var features = []

# Called when the node enters the scene tree for the first time.
func _ready():
	loadFeatureBlock()


func _process(_delta):

	if Input.is_action_just_released("ScrollUp"):
		scrollUp()
		print("up")
	if Input.is_action_just_released("ScrollDown"):
		scrollDown()

func newFeature():
	if pause == false:
		pause = true
		snewPopup = preload("res://scenes/popupsingle.tscn").instance()
		snewPopup.connect("submit",self,"setFeatureName")
		snewPopup.position.x = 0
		snewPopup.name("Feature Name")
		snewPopup.position.y = -50
		add_child(snewPopup)

func setFeatureName(): #button
	pause = false
	if snewPopup.currentData !="":
		for items in system.featuresArray:
			if items == snewPopup.currentData:
				snewPopup.currentData += "2"
		system.featuresArray.append(snewPopup.currentData)
		system.saveFeaturesArray()
		addFeatureBlock(snewPopup.currentData)
		reOrganize()



func reOrganize():

	var temps = "Left"
	var rightJump = 0
	var leftJump = 0

	for item in featureBlocks:
		if temps == "Left":
			temps = "Right"
			item.position.x = -305
			item.position.y = -200 + rightJump + savedScroll
			rightJump+= 250
			if item.featureCount > 4:
				rightJump+= item.featureCount*25 - 60
		elif temps == "Right":
			temps = "Left"
			item.position.x = 5
			item.position.y = -200 + leftJump + savedScroll
			leftJump+= 250
			if item.featureCount > 4:
				leftJump+= item.featureCount*25 - 60

		



	
	
var count = 0


func addFeatureBlock(s):
	count+=1
	var newPopup = preload("res://scenes/feature.tscn").instance()

	newPopup.position.y = posY
	newPopup.id = count
	
	if posX == "Left":
		posX = "Right"
		posY+= leftHeight*30
		newPopup.position.x = -311
		newPopup.side = "Left"
	elif posX == "Right":
		posY+= rightHeight*30
		posX = "Left"
		posY+=230 +newPopup.size*10
		newPopup.position.x = 4
		newPopup.side = "Right"
	newPopup.setName(s)
	
	
	add_child(newPopup)
	featureBlocks.append(newPopup)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func scrollUp():
	savedScroll += 30
	for items in featureBlocks:
		items.position.y+= 30


func scrollDown():
	savedScroll -= 30
	for items in featureBlocks:
		items.position.y-=30

var erasing = false
func eraseButton():
	if pause == false:
		if erasing == false:
			for items in featureBlocks:
				items.get_node("exit").visible = true
				for item in items.featureArr:
					item.get_node("exit").visible = true
			erasing = true
		elif erasing == true:
			for items in featureBlocks:
				items.get_node("exit").visible = false
				for item in items.featureArr:
					item.get_node("exit").visible = false
			erasing = false		


func loadFeatureBlock():
	for item in system.featuresArray:
		addFeatureBlock(item)
	reOrganize()
