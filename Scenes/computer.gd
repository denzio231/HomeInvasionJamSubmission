extends interactable
var isFunctioning = true
func mess():
	if isFunctioning:	return "Get Pendrive(e)"
	else: return "It no longer works"
func onInteract(player:CharacterBody3D):
	var pendrives = Global.get("PendrivesCaught")
	pendrives+=1
	Global.set("PendrivesCaught", pendrives)
	isFunctioning = false
