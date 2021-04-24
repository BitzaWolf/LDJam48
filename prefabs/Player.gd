extends KinematicBody2D
#signal signal_name
# Creates a custom event that you can fire off via emit_signal("signal_name")

# Script description here.

# enum NAME { name1, name2 }

export var gravity = 70
export var jumpSpeed = -1450
export (Array, int) var moveSpeeds = [300, 600, 900, 1500]
export (Array, float) var moveSpeedTimers = [0.5, 1.2, 3]
export (Array, float) var moveSpeedDeclineTimers = [5, 2, 0]

# export (PackedScene) var instancedSceneVariable
#     later on... var mob = instancedSceneVariable.instance(); add_child(mob);
var _velocity = Vector2()
var _isGrounded = true
var _currentSpeedLevel = 0
var _timeHeldForward = 0
var _timeNotMovingForward = 0

func get_current_speed():
    return moveSpeeds[_currentSpeedLevel]

func reset_speed():
    _currentSpeedLevel = 0
    _timeHeldForward = 0

# Activated when the node enters the Scene Tree and becomes active.
#func _ready():

# Runs after all of its children have also left. A destructor.
#func _exit_tree():

# The engine's internal game loop function. Delta is in seconds (float).
#func _process(delta):

# Engine's physics simulation game loop function. Called every fixed 1/60th of a second (by default)
func _physics_process(delta):
    if ($"/root/Game".is_game_over()):
        return
    
    _check_grounded_state()
    _get_input(delta)
    _increase_move_speed()
    _decrease_move_speed()
    _move_kinematic(delta)
    pass

func _check_grounded_state():
    _isGrounded = $ray_Grounded.is_colliding()

func _get_input(delta):
    _velocity.x = 0
    if (Input.is_action_pressed("move_left")):
        if (_isGrounded):
            $AnimatedSprite.flip_h = true
        _velocity.x = -1 * get_current_speed()
    if (Input.is_action_pressed("move_right")):
        if (_isGrounded):
            $AnimatedSprite.flip_h = false
        _velocity.x = get_current_speed()
        _timeHeldForward += delta
        _timeNotMovingForward = 0
    else:
        _timeHeldForward = 0
        _timeNotMovingForward += delta
    
    if (Input.is_action_just_pressed("jump") && _isGrounded):
        _velocity.y = jumpSpeed

func _increase_move_speed():
    if (_currentSpeedLevel >= moveSpeedTimers.size() || _velocity.x <= 0):
        return
    
    if (_timeHeldForward >= moveSpeedTimers[_currentSpeedLevel]):
        _timeHeldForward = 0
        _currentSpeedLevel += 1

func _decrease_move_speed():
    if (_currentSpeedLevel == 0 || _velocity.x > 0 || ! _isGrounded):
        return
    
    if (_timeNotMovingForward >= moveSpeedDeclineTimers[_currentSpeedLevel - 1]):
        _timeNotMovingForward = 0
        _currentSpeedLevel -= 1

func _move_kinematic(delta):
    _velocity.y += gravity
    _velocity = move_and_slide(_velocity, Vector2.UP)
