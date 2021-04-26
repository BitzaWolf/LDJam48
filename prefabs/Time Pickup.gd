extends AnimatedSprite
signal time_collected
#signal signal_name
# Creates a custom event that you can fire off via emit_signal("signal_name")

# Script description here.

# enum NAME { name1, name2 }

# export var publicVarsHere
export var animationSpeed = 1
# export (PackedScene) var instancedSceneVariable
#     later on... var mob = instancedSceneVariable.instance(); add_child(mob);
# var privateVarsHere
var _animTimer = 0
var _scale = Vector2(1, 0)

# Activated when the node enters the Scene Tree and becomes active.
func _ready():
    connect("time_collected", $"/root/Game", "on_time_collected")
    pass

# Runs after all of its children have also left. A destructor.
#func _exit_tree():

# The engine's internal game loop function. Delta is in seconds (float).
func _process(delta):
    _animTimer += delta * animationSpeed;
    _scale.x = cos(_animTimer)
    transform.x = _scale


# Engine's physics simulation game loop function. Called every fixed 1/60th of a second (by default)
#func _physics_process():


func _on_Area2D_body_entered(body):
    emit_signal("time_collected")
    animation = "hidden"
    $Area2D.hide()
    $AudioStreamPlayer2D.play()


func _on_AudioStreamPlayer2D_finished():
    queue_free()
    pass # Replace with function body.
