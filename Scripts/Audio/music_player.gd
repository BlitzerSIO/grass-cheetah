"""
   This file is part of:
   GODOT SONIC ENGINE

   Copyright (c) 2018- Stuart Moore.

   Licenced under the terms of the MIT "expat" license.

   Permission is hereby granted, free of charge, to any person obtaining
   a copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be
   included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.*/
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

"""
   music_player - a singleton to be used to play music (normally looped, but whatever is necessary).
   For more advanced stuff (music that relies on signals and so on), do it in the scene directly.
"""

extends AudioStreamPlayer

onready var bus_index = AudioServer.get_bus_index ("Music")

func _ready ():
	if (OS.is_debug_build ()):
		printerr ("Music player ready.")
	return

"""
   play_music
   music_player.play_music (path_to_music, play_from)
   Plays a specified music file (path_to_music). If it's left blank, it'll just play (if there was a music file loaded before).
   Will play from a specific point in the music (in seconds) if told to, unmuting the Music bus if need be.
   Returns true if it plays something, otherwise false.
"""
## TODO: This could make use of typed GDScript, in theory, as path_to_music is a string.
func play_music (path_to_music = "", play_from = 0.0):
	var play_me = null	# This will be used to set the stream data.
	if (path_to_music != ""):	# A path was specified, so load that up.
		play_me = load (path_to_music)
	else:	# No path was specified, so use whatever is in the stream to play.
		play_me = stream
	if (stream == null && play_me == null):	# Nothing to play - the stream was empty and no valid file was specified to play.
		# Can't play nothing, so error out!
		printerr ("ERROR: Can't play nothing; no valid file was specified to play and/or there was no stream set up before.")
		if (path_to_music != ""):
			printerr ("NOTE: ", path_to_music, " was specified as the file to play.")
		return (false)
	stream = play_me	# Everything's OK, so set the stream as needed...
	if (AudioServer.is_bus_mute (bus_index)):	# ...unmute Music if it's muted...
		AudioServer.set_bus_mute (bus_index, false)
	play (play_from)	# ...play the music...
	return (true)		# ...and return true.

"""
   stop_music
   music_player.stop_music ()
   Just a bit of syntactic sugar. Stops the currently playing music.
"""
func stop_music ():
	stop ()
	return
