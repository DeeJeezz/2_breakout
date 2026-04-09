extends CanvasLayer
class_name UI


@export var hp_label: Label
@export var score_label: Label

@export var menu_panel: Panel

@export_category("SFX")
@export var pause_sfx: AudioStreamPlayer
@export var resume_sfx: AudioStreamPlayer


func set_hp(hp: int) -> void:
	hp_label.text = "%s" % hp


func set_score(score: int) -> void:
	score_label.text = "%s" % score


func show_menu() -> void:
	menu_panel.show()
	pause_sfx.play()
	
	
func hide_menu() -> void:
	menu_panel.hide()
	resume_sfx.play()


func _on_restart_button_button_down() -> void:
	Signals.restart_game.emit()


func _on_quit_button_button_down() -> void:
	Signals.exit_game.emit()


func _on_resume_button_button_down() -> void:
	Signals.resume_game.emit()
