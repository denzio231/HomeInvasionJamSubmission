extends interactable
var isFunctioning = true
var isFirst = true
func mess():
	return "Use Computer(e)"
func onInteract(player:CharacterBody3D):
	player.get_node("CanvasLayer").hide()
	player.canMove = false
	if isFirst: $CanvasLayer/ComputerUi.startUp();isFirst=false
	else:
		$CanvasLayer/ComputerUi.perm_focus()
		
	if Global.pendriveHeld:
		$CanvasLayer/ComputerUi.setPenDrive(Global.pendriveHeld)
	
	$CanvasLayer/ComputerUi.show()
	$CanvasLayer/ComputerUi.connect("quit",func(): 
		player.canMove = true
		player.get_node("CanvasLayer").show()
	,CONNECT_ONE_SHOT)
