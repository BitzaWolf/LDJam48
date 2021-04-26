extends ParallaxBackground
#signal signal_name
# Creates a custom event that you can fire off via emit_signal("signal_name")

# Script description here.

# enum NAME { name1, name2 }

# export (PackedScene) var instancedSceneVariable
#     later on... var mob = instancedSceneVariable.instance(); add_child(mob);
# var privateVarsHere

# Activated when the node enters the Scene Tree and becomes active.
func _ready():
    $ParallaxLayer.motion_mirroring = Vector2(1024, 1024)

# Runs after all of its children have also left. A destructor.
#func _exit_tree():

# The engine's internal game loop function. Delta is in seconds (float).
# func _process(delta):

# Engine's physics simulation game loop function. Called every fixed 1/60th of a second (by default)
#func _physics_process():
