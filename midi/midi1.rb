require 'java'

midi = javax.sound.midi
import midi.MidiSystem
import midi.Sequence
import midi.MidiEvent
import midi.ShortMessage

while (line = gets) !~ /exit/
  # Construct a new sequence using 2 beats per quarter note
  seq = Sequence.new Sequence::PPQ, 2
  track = seq.create_track

  # add each character into track as a note
  for i in 0...line.length do
    msg = ShortMessage.new
    msg.set_message(ShortMessage::NOTE_ON, line[i], 64)
    track.add MidiEvent.new(msg, i)
  end

  # add a STOP to end the track
  msg = ShortMessage.new
  msg.message = ShortMessage::STOP
  track.add MidiEvent.new msg, i + 1

  # open the sequencer and play the sequence
  seqer = MidiSystem.sequencer
  seqer.open
  seqer.sequence = seq
  seqer.start
end
java.lang.System.exit(0)
