extends CanvasLayer

func show():
    $TextureRect.show()
    $PanelContainer.show()
    
    var score = $"/root/Game".get_score()
    $"PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/lbl Score".text = comma_sep(score)
    
    var ranking = "Wolf Puppy"
    if (score < 3000):
        ranking = "Wolf Puppy"
    elif (score < 6000):
        ranking = "Wild Wolf"
    elif (score < 10000):
        ranking ="Running Wild!"
    else:
        ranking = "WOLF MASTER!"
    
    $"PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/lbl Ranking".text = ranking

func hide():
    $TextureRect.hide()
    $PanelContainer.hide()

func comma_sep(number):
    var string = str(number)
    var mod = string.length() % 3
    var res = ""

    for i in range(0, string.length()):
        if i != 0 && i % 3 == mod:
            res += ","
        res += string[i]

    return res

func _on_butt_Again_pressed():
    $"/root/Game".start_new_game()

func _on_butt_Main_pressed():
    $"/root/Game".return_to_menu()
