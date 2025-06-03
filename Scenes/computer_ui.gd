extends Control
@onready var Console = $TextEdit

# Called when the node enters the scene tree for the first time.
var maxPos = 0
var lastText = ""
var cols = 0
var lines = 0
func setUneditableString(text):
	Console.text+=text
	maxPos = len(Console.text)
func pwd():
	Console.editable=false
	setUneditableString("C:/>")
	Console.editable=true
	onTextChange()
	onCaretChange()
func onTextChange():
	if len(Console.text) < maxPos:
		Console.text = lastText
	cols+=len(Console.text)-len(lastText)
	print(cols)
	if Console.text[-1] == "\n":
		lines+=1
		cols=0
		pwd()
	lastText = Console.text
func onCaretChange():
	#if Console.get_caret_index_edit_order():
	Console.set_caret_column(cols)
	Console.set_caret_line(lines)
	#print(Console.get_caret_line())
func _ready() -> void:
	Console.grab_focus()
	Console.connect("focus_exited",Console.grab_focus,CONNECT_PERSIST)
	Console.connect("text_changed",onTextChange,CONNECT_PERSIST)
	Console.connect("text_changed",onTextChange,CONNECT_PERSIST)
	Console.connect("caret_changed",onCaretChange,CONNECT_PERSIST)
	pwd()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
