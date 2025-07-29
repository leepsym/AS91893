extends Node
class_name Data

@onready var encryption : String
@onready var encrypted : bool
@onready var type : String
@onready var size : int

func _init(enct: String, enc: bool, typ: String, siz: int):
	encryption = enct
	encrypted = enc
	type = typ
	size = siz
