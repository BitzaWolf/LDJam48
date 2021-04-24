extends CanvasLayer
#signal signal_name
# Creates a custom event that you can fire off via emit_signal("signal_name")

# Script description here.

# enum NAME { name1, name2 }

# export var publicVarsHere
# export (PackedScene) var instancedSceneVariable
#     later on... var mob = instancedSceneVariable.instance(); add_child(mob);
# var privateVarsHere

func set_timer(percentage):
    $MarginContainer2/LifeCounter.value = 100 * percentage

func set_score(amount):
    $MarginContainer/HBoxContainer/Score.text = comma_sep(amount)

func comma_sep(number):
    var string = str(number)
    var mod = string.length() % 3
    var res = ""

    for i in range(0, string.length()):
        if i != 0 && i % 3 == mod:
            res += ","
        res += string[i]

    return res
# Activated when the node enters the Scene Tree and becomes active.
#func _ready():

# Runs after all of its children have also left. A destructor.
#func _exit_tree():

# The engine's internal game loop function. Delta is in seconds (float).
#func _process(delta):

# Engine's physics simulation game loop function. Called every fixed 1/60th of a second (by default)
#func _physics_process():
