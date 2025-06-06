extends interactable
@export var anim:SpriteFrames
func mess() -> String:
	return "Grab pendrive(e)"
func onInteract(player:CharacterBody3D):
	var pendrives = Global.get("PendrivesCaught")
	pendrives+=1
	Global.set("PendrivesCaught", pendrives)
	player.loadAnim(anim)
	queue_free()
