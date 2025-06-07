extends CharacterBody3D

const SPEED = 5.0
var sens = 0.3
var currentHover:StaticBody3D = null
var canMove = true
var attacking = false
@onready var AnimSprite:AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready var cam = $Camera3D
@onready var HITBOX:Area3D = $Area3D
@onready var AmbientSound:AudioStreamPlayer3D = $AudioStreamPlayer3D

func loadAnim(anim:SpriteFrames):
	AnimSprite.sprite_frames = anim
	AnimSprite.play("wield")
	await AnimSprite.animation_finished
	AnimSprite.play("idle")
func _input(event):
	if canMove:
		if event is InputEventMouseMotion:
			$Camera3D.rotation_degrees.x -= event.relative.y*sens
			rotation_degrees.y -= event.relative.x*sens
			$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-90,90)
		elif event.is_action_pressed("INTERACT"):
			if currentHover: currentHover.onInteract(self)
		elif event.is_action_pressed("FOCUS"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif event.is_action_pressed("ATTACK") and not attacking and Global.pendriveHeld:
			if AnimSprite.sprite_frames and Global.pendriveHeld.loaded:
				if AnimSprite.sprite_frames.has_animation("attack"):
					attacking = true
					AnimSprite.play("attack")
					var bodies = HITBOX.get_overlapping_bodies()
					for i in bodies:
						if i.has_method('deal_damage'):
							i.deal_damage()
					await AnimSprite.animation_finished
					AnimSprite.play("idle")
					attacking = false
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	AmbientSound.play()
	#$CanvasLayer/AnimatedSprite2D.play("wieldUSB")
	#await $CanvasLayer/AnimatedSprite2D.animation_finished
	#$CanvasLayer/AnimatedSprite2D.play("idleUSB")
func showText(text):
	$CanvasLayer/RichTextLabel.text = text
	$CanvasLayer/RichTextLabel.show()
func hideText():
	$CanvasLayer/RichTextLabel.text = ""
	$CanvasLayer/RichTextLabel.hide()
func getRayResult(length):
	var space_state = get_world_3d().direct_space_state
	var pos = get_viewport().get_visible_rect().size/2
	var origin = cam.project_ray_origin(pos)
	var end = origin + cam.project_ray_normal(pos) * length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	query.exclude = [HITBOX]
	return space_state.intersect_ray(query)
var RAY_LENGTH = 4
var is_visible = false
func _physics_process(delta: float) -> void:
	var result = getRayResult(RAY_LENGTH)
	var noSelection = true
	Global.Player = self
	if result.has("collider") and canMove:
			var res:Node3D = result.collider
			if res.is_in_group("interactable"):
				noSelection = false
				if res != currentHover:
					currentHover = res
					is_visible = true
					showText(currentHover.mess())
	if noSelection and is_visible:
		hideText()
		currentHover = null
		is_visible = false
	if not is_on_floor():
		velocity += get_gravity() * delta
	var input_dir := Vector2.ZERO
	if canMove:
		input_dir = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	var direction := (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
