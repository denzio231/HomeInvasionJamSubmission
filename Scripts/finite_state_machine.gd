extends Node
class_name FSM
@onready var states:Array[Node] = get_children()
@export var default_state:stateNode
var current_state:stateNode
func set_state(state:stateNode):
	current_state = state
	current_state.enter(get_parent())
func _physics_process(delta: float) -> void:
	var nextState = current_state.physicsHandler(delta)
	if nextState:
		set_state(nextState)
func _input(event: InputEvent) -> void:
	var nextState = current_state.inputHandler(event)
	if nextState:
		set_state(nextState)
func _ready() -> void:
	set_state(default_state)
