extends CanvasLayer
class_name UI

@export_category("HUD")
@export var hud_hp_label: Label
@export var hud_score_label: Label
@export var hud_record_label: Label

@export_category("Game over screen")
@export var record_score_label: Label
@export var game_over_score_label: Label

@export_category("Panels")
@export var menu_panel: Panel
@export var game_over_panel: Panel
@export var start_game_panel: Panel

@export_category("SFX")
@export var pause_sfx: AudioStreamPlayer
@export var resume_sfx: AudioStreamPlayer


func prepare_game(record_score: int) -> void:
	if record_score > 0:
		hud_record_label.text = "%s" % record_score
	else:
		hud_record_label.text = ""
	start_game_panel.show()
	
	
func show_start_screen() -> void:
	start_game_panel.show()
	
	
func hide_start_screen() -> void:
	start_game_panel.hide()


func set_hp(hp: int) -> void:
	hud_hp_label.text = "%s" % hp


func set_score(score: int) -> void:
	hud_score_label.text = "%s" % score


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


func _on_restart_button_button_down() -> void:
	Signals.restart_game.emit()


func _on_quit_button_button_down() -> void:
	Signals.exit_game.emit()


func _on_resume_button_button_down() -> void:
	Signals.resume_game.emit()
