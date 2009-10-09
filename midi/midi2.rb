require 'java'

import javax.sound.midi.MidiSystem
import javax.swing.JFrame
import java.awt.event.KeyListener

# Prepare the synth, get channel 0
synth = MidiSystem.synthesizer
synth.open
channel = synth.channels[0]

# Prepare a frame to receive keystrokes
frame = JFrame.new("Music Frame")
frame.set_size 300, 300
frame.default_close_operation = JFrame::EXIT_ON_CLOSE

# Listen for keystrokes, play notes
frame.add_key_listener KeyListener.impl { |name, event|
  case name
  when :keyPressed
    channel.note_on event.key_char, 64
  when :keyReleased
    channel.note_off event.key_char
  end
}

# Show the frame
frame.visible = true
