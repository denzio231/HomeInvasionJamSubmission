extends interactable
var closed = true
var drawLength = 5
func mess() -> String:
	return "Open drawer(e)"
func onInteract(player:CharacterBody3D):
	var tween = create_tween()
	if closed:
		tween.tween_property(self,"position",Vector3(0,0,drawLength),1.0).as_relative()
	else:
		tween.tween_property(self,"position",Vector3(0,0,-drawLength),1.0).as_relative()
	closed = not closed
