extends Control
class_name UI


@export var hp_label: Label


func set_hp(hp: int) -> void:
	hp_label.text = "%s" % hp
