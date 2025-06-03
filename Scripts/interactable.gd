extends StaticBody3D
class_name interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("interactable")
func mess() -> String:
	return "Override this"
func onInteract(player:CharacterBody3D):
	print('over ride this')
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
