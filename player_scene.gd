extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sens = 0.3
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y*sens
		rotation_degrees.y -= event.relative.x*sens
		rotation_degrees.x = clamp(rotation_degrees.x,-90,90)
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Input.get_vector("LEFT","RIGHT","UP","DOWN")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
