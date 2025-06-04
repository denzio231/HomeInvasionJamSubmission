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

var cmds = {
	"clear" : {
		"desc" : "Clears text from console",
		"call" : consoleClear
	},
	"quit" : {
		"desc" : "Quits console",
		"call" : consoleQuit
	}
}
