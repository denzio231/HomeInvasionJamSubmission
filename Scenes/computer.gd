extends interactable
var isFunctioning = true
func mess():
	if isFunctioning:	return "Get Pendrive(e)"
	else: return "It no longer works"
func onInteract(player:CharacterBody3D):
	player.canMove = false
	$CanvasLayer/ComputerUi.perm_focus()
	$CanvasLayer/ComputerUi.show()
	$CanvasLayer/ComputerUi.connect("quit",func(): 
		player.canMove = true
	,CONNECT_ONE_SHOT)
	var pendrives = Global.get("PendrivesCaught")
	pendrives+=1
	Global.set("PendrivesCaught", pendrives)
	isFunctioning = false
