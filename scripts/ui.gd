extends CanvasLayer
class_name UI

@export_category("Labels")
@export var hp_label: Label
@export var score_label: Label
@export var record_score_label: Label
@export var game_over_score_label: Label

@export_category("Panels")
@export var menu_panel: Panel
@export var game_over_panel: Panel

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
	
	
func game_over(score: int) -> void:
	game_over_score_label.text = "Current score: %s" % score
	game_over_panel.show()
	
	
func set_record_score(score: int) -> void:
	record_score_label.text = "Max score: %s" % score
	print(record_score_label.text)


func _on_restart_button_button_down() -> void:
	Signals.restart_game.emit()


func _on_quit_button_button_down() -> void:
	Signals.exit_game.emit()


func _on_resume_button_button_down() -> void:
	Signals.resume_game.emit()
