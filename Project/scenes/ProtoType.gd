extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var newPopup
var pause = false
var system
var desc
# Called when the node enters the scene tree for the first time.
func _ready():
	
	system = get_node("/root/System")
	get_node("title").text = get_parent().proj.name
	
	desc = system.loadProjsDesc("prototototos")
	get_node("desc").text = desc

func editDescription():
	
	desc = get_node("desc").text
	system.saveProjsDesc("prototototos",desc)




