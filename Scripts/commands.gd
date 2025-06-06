extends Node2D
@onready var ConsoleControl = get_parent()
@onready var Console = get_parent().get_node("TextEdit")
func consoleQuit():
	ConsoleControl.quitConsole()
func consoleClear():
	Console.text = ""
	ConsoleControl.maxPos = 0
	ConsoleControl.cols = 0
	ConsoleControl.lines = 0
	ConsoleControl.colOveride = true
	ConsoleControl.onTextChange()
func consoleCmds():
	for i in cmds.keys():
		ConsoleControl.consolePrint(i+": "+cmds[i].desc)
func writePenDrive():
	var penDrive = ConsoleControl.penDriveConnected
	if not penDrive:
		ConsoleControl.consolePrint("Pendrive not equipped")
		return
	var timer = get_tree().create_timer(penDrive.t)
	var progessInterval = 10
	var lastUpdate = -1
	while timer.time_left>0:
		var progress = ((penDrive.t-timer.time_left)/penDrive.t)*100
		if snapped(progress,progessInterval)>lastUpdate:
			ConsoleControl.consolePrint("Progress: " + str(snapped(progress,progessInterval)))
			lastUpdate = snapped(progress,progessInterval)
		await get_tree().create_timer(0.1).timeout
	ConsoleControl.consolePrint("Loading completed: ")
	penDrive.loaded = true
	print('loading')
var cmds = {
	"clear" : {
		"desc" : "Clears text from console",
		"call" : consoleClear
	},
	"quit" : {
		"desc" : "Quits console",
		"call" : consoleQuit
	},
	"cmds" : {
		"desc" : "Lists commands",
		"call" : consoleCmds
	},
	"write" : {
		"desc" : "writes needed code to pendrive which is connected",
		"call" : writePenDrive
	}
}
