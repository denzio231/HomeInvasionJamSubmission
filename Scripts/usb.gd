extends interactable
@export var anim:SpriteFrames
var t = randf()*30+20
var loaded = false
func mess() -> String:
	return "Grab pendrive(e)"
func onInteract(player:CharacterBody3D):
	var pendrives = Global.get("PendrivesCaught")
	Global.set("pendriveHeld", self)
	player.loadAnim(anim)
	get_parent().remove_child(self)
