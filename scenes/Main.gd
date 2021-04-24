extends Node
#signal signal_name
# Creates a custom event that you can fire off via emit_signal("signal_name")

# Script description here.

# enum NAME { name1, name2 }

# export var publicVarsHere
export var startTime = 30
export var timerPerPickup = 1
export var scorePerTimePickup = 1000
export var distanceMultiplier = 1
export (Array, PackedScene) var sections
#     later on... var mob = instancedSceneVariable.instance(); add_child(mob);
# var privateVarsHere
var SECTION_WIDTH = 4096
var PLACE_NEXT_SECTION_BUFFER = 4096 + 2048
var _nextSectionPlacement = 0
var _timeRemaining = startTime
var _bonusScore = 0
var _deepestForward = 0 # Gotta use the Theme somehow, right? aka Furthest Forward

func get_score():
    return (_deepestForward * distanceMultiplier + _bonusScore)

func on_time_collected():
    _timeRemaining = min(timerPerPickup + _timeRemaining, startTime)
    _bonusScore += scorePerTimePickup

func is_game_over():
    return _timeRemaining <= 0

# Activated when the node enters the Scene Tree and becomes active.
func _ready():
    randomize()
    _nextSectionPlacement = SECTION_WIDTH * $Sections.get_child_count()

# Runs after all of its children have also left. A destructor.
#func _exit_tree():

# The engine's internal game loop function. Delta is in seconds (float).
func _process(delta):
    if (is_game_over()):
        return
    
    _decrease_time(delta)
    _update_UI()
    _check_and_place_next_section()
    if (is_game_over()):
        print("Game Over")

func _decrease_time(delta):
    _timeRemaining = max(_timeRemaining - delta, 0)

func _update_UI():
    $"Game UI".set_timer(_timeRemaining / startTime)
    $"Game UI".set_score(get_score())

func _check_and_place_next_section():
    var playerPosition = $Player.position.x
    if (playerPosition >= _nextSectionPlacement - PLACE_NEXT_SECTION_BUFFER):
        var sectionIndex = randi() % sections.size()
        var newSection = sections[sectionIndex].instance()
        $Sections.add_child(newSection)
        newSection.transform.origin = Vector2(_nextSectionPlacement, 0)
        _nextSectionPlacement += SECTION_WIDTH


# Engine's physics simulation game loop function. Called every fixed 1/60th of a second (by default)
func _physics_process(delta):
    var posAsInt = int($Player.position.x)
    _deepestForward = max(_deepestForward, posAsInt)
