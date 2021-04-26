extends CanvasLayer

func hide():
    $TextureRect.hide()
    $MarginContainer.hide()

func show():
    $TextureRect.show()
    $MarginContainer.show()

func _on_butt_New_Game_pressed():
    $"/root/Game".start_new_game()


func _on_butt_Options_pressed():
    $MarginContainer.hide()
    $PanelContainer.show()


func _on_slide_Audio_value_changed(value):
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _val_to_db(value))

func _val_to_db(slideValue):
    slideValue = min(99, slideValue)
    var db = log(100 - slideValue) * -3
    return db


func _on_butt_Close_Options_pressed():
    $PanelContainer.hide()
    $MarginContainer.show()
