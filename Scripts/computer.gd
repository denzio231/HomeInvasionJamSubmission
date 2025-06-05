extends interactable
var isFunctioning = true
func mess():
	return "Use Computer(e)"
func onInteract(player:CharacterBody3D):
	player.get_node("CanvasLayer").hide()
	player.canMove = false
	$CanvasLayer/ComputerUi.perm_focus()
	$CanvasLayer/ComputerUi.show()
	$CanvasLayer/ComputerUi.connect("quit",func(): 
		player.canMove = true
		player.get_node("CanvasLayer").show()
	,CONNECT_ONE_SHOT)
