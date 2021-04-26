extends Node

# Abscond into the Woods
# A short 2D platformer/runner by Bitzawolf for Ludum Dare jam 48
# https://bitzawolf.com
# @Bitzawolf

enum STATE { MAIN_MENU, PLAYING, GAME_OVER }

# export var publicVarsHere
export var startTime = 30
export var timerPerPickup = 1
export var scorePerTimePickup = 100
export var distanceMultiplier = .1
export (Array, PackedScene) var sections

# var privateVarsHere
var SECTION_WIDTH = 4096
var PLACE_NEXT_SECTION_BUFFER = 4096 + 2048
var _nextSectionPlacement = 0
var _timeRemaining = startTime
var _bonusScore = 0
var _deepestForward = 0 # Gotta use the Theme somehow, right? aka Furthest Forward
var _currentState = STATE.MAIN_MENU

func get_score():
    return (int(_deepestForward * distanceMultiplier) + _bonusScore)

func on_time_collected():
    _timeRemaining = min(timerPerPickup + _timeRemaining, startTime)
    _bonusScore += scorePerTimePickup

func is_game_over():
    return _timeRemaining <= 0

func is_in_game():
    return _currentState == STATE.PLAYING

func start_new_game():
    _currentState = STATE.PLAYING
    
    $"Main Menu UI".hide()
    $"Game Over".hide()
    $"Game UI".show()
    
    $"music menu".stop()
    $"music loop".stop()
    $"music outro".stop()
    $"music Intro".play()
    
    _nextSectionPlacement = 0
    _timeRemaining = startTime
    _bonusScore = 0
    _deepestForward = 0
    $Player.position.x = 96
    $Player.position.y = 623
    for kiddo in $Sections.get_children():
        kiddo.queue_free()

func return_to_menu():
    _currentState = STATE.MAIN_MENU
    $"Game UI".hide()
    $"Game Over".hide()
    $"Main Menu UI".show()
    
    $"music Intro".stop()
    $"music loop".stop()
    $"music outro".stop()
    $"music menu".play()

# Activated when the node enters the Scene Tree and becomes active.
func _ready():
    randomize()
    _nextSectionPlacement = SECTION_WIDTH * $Sections.get_child_count()


# The engine's internal game loop function. Delta is in seconds (float).
func _process(delta):
    if (is_game_over()):
        return
        
    _decrease_time(delta)
    _update_UI()
    _check_and_place_next_section()
    if (is_game_over()):
        _end_game()

func _decrease_time(delta):
    _timeRemaining = max(_timeRemaining - delta, 0)

func _update_UI():
    $"Game UI".set_timer(_timeRemaining / startTime)
    $"Game UI".set_score(get_score())

func _end_game():
    _currentState = STATE.GAME_OVER
    
    $"Game UI".hide()
    $"Main Menu UI".hide()
    
    $"music Intro".stop()
    $"music loop".stop()
    $"music outro".play()
    $"Game Over".show()

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


func _on_music_Intro_finished():
    if (_currentState == STATE.PLAYING):
        $"music loop".play()


func _on_music_loop_finished():
    if (_currentState == STATE.PLAYING):
        $"music loop".play()


func _on_music_menu_finished():
    if (_currentState == STATE.MAIN_MENU):
        $"music loop".play()
