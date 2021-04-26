extends CanvasLayer

func hide():
    $MarginContainer.hide()
    $MarginContainer2.hide()

func show():
    $MarginContainer.show()
    $MarginContainer2.show()

func set_timer(percentage):
    $MarginContainer2/LifeCounter.value = 100 * percentage

func set_score(amount):
    $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/Score.text = comma_sep(amount)

func comma_sep(number):
    var string = str(number)
    var mod = string.length() % 3
    var res = ""

    for i in range(0, string.length()):
        if i != 0 && i % 3 == mod:
            res += ","
        res += string[i]

    return res
