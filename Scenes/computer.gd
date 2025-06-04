extends interactable
func mess():
	return "Use computer(e)"
func onInteract(player:CharacterBody3D):
	player.canMove = false
	$CanvasLayer/ComputerUi.perm_focus()
	$CanvasLayer/ComputerUi.show()
	$CanvasLayer/ComputerUi.connect("quit",func(): 
		player.canMove = true
	,CONNECT_ONE_SHOT)
