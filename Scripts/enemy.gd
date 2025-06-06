extends CharacterBody3D
@onready var raycast = $MeshInstance3D/RayCast3D
@onready var audio = $AudioStreamPlayer3D
var speed = 1
var pitch = 1
#func _ready():
	#audio.play()
	
func _process(delta):
	var playerPosition = Global.get("Player")
	
	look_at(playerPosition.position)
	velocity = -basis.z * speed
	move_and_slide()
	#RayCast3D.new().
	#print(raycast.get_collider())
	if raycast.get_collider():
		if(raycast.get_collider().get("name") == "CharacterBody3D"): 
			speed *= 1.0005
		
