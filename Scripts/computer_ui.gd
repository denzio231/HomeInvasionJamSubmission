extends Control
@onready var Console = $TextEdit
signal quit
# Called when the node enters the scene tree for the first time.
var maxPos = 0
var lastText = ""
var cols = 0
var lines = 0
var isUsr = true
var penDriveConnected = null
func setPenDrive(pendrive):
	penDriveConnected = pendrive
func setUneditableString(text):
	Console.text+=text
	maxPos = len(Console.text)
func pwd():
	Console.editable=false
	setUneditableString("C:/>")
	Console.editable=true
	onTextChange()
	onCaretChange()
func quitConsole():
	quit.emit()
	Console.disconnect("focus_exited",Console.grab_focus)
	hide()
	Console.release_focus()
var colOveride = false
func consolePrint(text):
	setUneditableString(text+"\n")
	onTextChange()
func cmd(text):
	text = text.rstrip("\n")
	var arr = text.split(" ")
	var cmd = arr[0]
	var commandT = $Commands.cmds.get(cmd)
	if commandT:
		var commandFunc = commandT.call
		await commandFunc.call()
	else:
		consolePrint("Not a command")
func onTextChange():
	if len(Console.text) < maxPos:
		Console.text = lastText
	if colOveride:
		colOveride = false
	else:
		cols+=len(Console.text)-len(lastText)
	
	print(cols)
	if len(Console.text)>0:
		if Console.text[-1] == "\n":
			lines+=1
			cols=0
			if isUsr:
				isUsr = false
				var cmdLength = len(Console.text)-maxPos
				var cmdString = Console.text.substr(len(Console.text)-cmdLength,len(Console.text))
				print(cmdString)
				await cmd(cmdString)
				pwd()
				isUsr = true
	lastText = Console.text
func onCaretChange():
	#if Console.get_caret_index_edit_order():
	Console.set_caret_column(cols)
	Console.set_caret_line(lines)
	#print(Console.get_caret_line())
func perm_focus():
	Console.connect("focus_exited",Console.grab_focus,CONNECT_PERSIST)
	await get_tree().create_timer(0.1).timeout
	Console.grab_focus()
func _ready() -> void:
	Console.release_focus()
	Console.connect("text_changed",onTextChange,CONNECT_PERSIST)
	Console.connect("text_changed",onTextChange,CONNECT_PERSIST)
	Console.connect("caret_changed",onCaretChange,CONNECT_PERSIST)
	pwd()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
