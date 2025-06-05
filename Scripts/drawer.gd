extends interactable
@onready var pathFollow:PathFollow3D = $Path3D/PathFollow3D
var closed = true
func mess() -> String:
	return "Open drawer"
func onInteract(player:CharacterBody3D):
	var tween = get_tree().create_tween()
	if closed:
		tween.tween_property(pathFollow,"progress",1.0,1.0)
	else:
		tween.tween_property(pathFollow,"progress",0.0,1.0)
