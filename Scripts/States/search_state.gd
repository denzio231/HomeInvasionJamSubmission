extends stateNode
@export var waryState:stateNode
@export var chaseState:stateNode
var mainNode:CharacterBody3D
var detectorArea:Area3D
func enter(mN):
	mainNode = mN
	mainNode.SPEED = 2
	mainNode.FOV = 160
	detectorArea = mainNode.get_node("Area3D")
func search(delta):
	if not mainNode.target:
		return
	if (mainNode.target.global_position-mainNode.global_position).length()<1:
		mainNode.chooseMarker()
	mainNode.navAgent.target_position = mainNode.target.global_position
	var dir = (mainNode.navAgent.get_next_path_position()-mainNode.global_position).normalized()
	mainNode.velocity = mainNode.velocity.move_toward(dir*mainNode.SPEED,mainNode.SPEED)
	mainNode.look_at(mainNode.position+dir*Vector3(1,0,1))
	mainNode.move_and_slide()
func physicsHandler(delta:float):
	search(delta)
	if mainNode.isPlayerVisible():
		return chaseState
