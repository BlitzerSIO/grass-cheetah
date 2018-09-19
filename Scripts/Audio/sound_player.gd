"""
   For playing general sound effects (mostly UI, but other stuff too as required).
   Sound effects MUST be specified in Sound_Library along the lines of "<name>": preload ("<filename>").
   (Or <name> = preload ("<filename>"), your choice.) (Or "<name>": load ("<filename>") etc etc.)
   Sound effects can be played using sound_player.play_sound ([<name>])

   Note it doesn't use 2D or 3D; it's best used for UI sounds or other sounds that don't need to consider their positions.
"""

extends AudioStreamPlayer

onready var bus_index = AudioServer.get_bus_index ("SFX")

onready var Sound_Library = {
	# Put all the sound effects to be used globally here.
	No_Sound = preload ("res://Audio/Sound/No_Sound.ogg"),	# Keep this as the first item in the list.
	Destroy_Badnik = preload ("res://Audio/Sound/Hit_Badnik.ogg"),
	Get_Ring = preload ("res://Audio/Sound/Get_Ring.ogg"),
	Jump = preload ("res://Audio/Sound/Jump.ogg"),
	Lose_Rings = preload ("res://Audio/Sound/Lose_Rings.ogg"),
}

func _ready ():
	if (OS.is_debug_build ()):
		printerr ("Sound player ready.")
	return

"""
   play_sound
   play_sound (item)
   Looks for item in Sound_Library and if it's there, play it.
   Returns true if the item was found and the sound played, false otherwise.
"""
func play_sound (item = "No_Sound"):
	if (item in Sound_Library):
		# The sound exists in the library, so play it out and return true.
		stream = Sound_Library [item]
		play ()
		return (true)
	# Sound not found, so give an error and return false.
	printerr ("ERROR: \"", item, "\" not found!")
	return (false)

"""
   stop_sound
   Stops the sound player (if you're using looped sound effects, for example).
"""
func stop_sound ():
	stop ()
	return
