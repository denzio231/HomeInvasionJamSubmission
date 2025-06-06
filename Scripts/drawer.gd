extends interactable
@onready var pathFollow:PathFollow3D = get_parent().get_node("PathFollow3D")
var closed = true
func mess() -> String:
	return "Open drawer(e)"
func onInteract(player:CharacterBody3D):
	var tween = create_tween()
	if closed:
		tween.tween_property(pathFollow,"progress_ratio",1.0,1.0)
	else:
		tween.tween_property(pathFollow,"progress_ratio",0.0,1.0)
	closed = not closed
