@tool
extends Control

@onready var ProjectName: LineEdit = $MarginContainer/VBoxContainer/ProjName
@onready var Author: LineEdit = $MarginContainer/VBoxContainer/Author
@onready var ProjectVersion: LineEdit = $MarginContainer/VBoxContainer/ProjVer
@onready var ProjectDescription: LineEdit = $MarginContainer/VBoxContainer/ProjDesc

func _on_create_pressed() -> void:
	if ProjectName.text != "" and Author.text != "":
		
		## Needed vars dont delete
		var Dir = DirAccess.open("res://")
		var Json = JSON.new()
		
		## If the version text is left empty we fill it with '1.0.0'
		if ProjectVersion.text == "":
			ProjectVersion.text = "1.0.0"
		
		## Makes a Mods directory if there isnt already one
		if !Dir.dir_exists("res://Mods"):
			Dir.make_dir("Mods")
		
		## Makes the mod file structure
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text)
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/Scenes")
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/Worlds")
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/Objects")
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/Entities")
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/MeshFiles")
		Dir.make_dir_absolute("res://Mods/" + Author.text + "-" + ProjectName.text + "/AutoloadScripts")
		
		## Garbage collection stuff
		Dir = null
		
		var ManifestData = {"ProjectAuthor": Author.text, "ProjectProjectName": ProjectName.text, "ProjectProjectVersion": ProjectVersion.text, "ProjectProjectDescription": ProjectDescription.text}
		SaveManifest(ManifestData)
		
		## Garbage collection stuff
		ManifestData = null
		
		
		## Restarts the editor
		EditorInterface.restart_editor(true)
	
	else:
		if Author.text == "" and ProjectName.text == "":
			printerr("Author and Project Name needs to be filled")
		elif Author.text == "":
			printerr("Author needs to be filled")
		elif ProjectName.text == "":
			printerr("Project Name needs to be filled")

func SaveManifest(Manifest) -> void:
	## Saves json data
	var File := FileAccess.open("res://Mods/" + Author.text + "-" + ProjectName.text + "/Manifest.json", FileAccess.WRITE)
	File.store_string(JSON.stringify(Manifest, "	"))
	
	## Garbage collection stuff
	File.close()
	File = null
