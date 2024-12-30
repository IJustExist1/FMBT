@tool
extends EditorPlugin

var ProjectMaker
var LevelTools

func _enter_tree() -> void:
	## Initialization of the plugin goes here.
	ProjectMaker = preload("res://addons/FBMT/ProjectMaker/ProjectMaker.tscn").instantiate()
	LevelTools = preload("res://addons/FBMT/ModTools/ModTools.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, ProjectMaker)
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, LevelTools)


func _exit_tree() -> void:
	## Clean-up of the plugin goes here.
	remove_control_from_docks(ProjectMaker)
	remove_control_from_docks(LevelTools)
	ProjectMaker.free()
	LevelTools.free()
