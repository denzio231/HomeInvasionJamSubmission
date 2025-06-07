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

func listPartitions():
	pass

func repairPartition():
	pass
func consoleCmds():
	for i in cmds.keys():
		ConsoleControl.consolePrint("\t" + i +": "+cmds[i].desc)
var cmds = {
	"clr" : {
		"desc" : "Clears text from console",
		"call" : consoleClear
	},
	"quit" : {
		"desc" : "Quits console",
		"call" : consoleQuit
	},
	"help" : {
		"desc" : "Lists commands",
		"call" : consoleCmds
	},
	"lsblk":{
		"desc": "List Partitions",
		"call": listPartitions
	},
	"repair":{
		"desc":"Repair corrupted files",
		"call": repairPartition
	},
	"ls":{
		"desc":"List files",
		"call": ""
	},
	"cat":{
		"desc":"Print files to the console",
		"call":""
	}
	
}
