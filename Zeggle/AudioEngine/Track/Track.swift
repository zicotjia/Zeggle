//
//  Sequence.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

import AudioToolbox

class Track {
    var notes: [NoteBeat] = []

    init() {

    }

    init(notes: [NoteBeat]) {
        self.notes = notes
    }

    func addNoteBeat(noteBeat: NoteBeat) {
        notes.append(noteBeat)
    }

    func addNoteBeats(noteBeats: [NoteBeat]) {
        notes.append(contentsOf: noteBeats)
    }

    func resetTrack() {
        notes = []
    }

    func createSequence() -> MusicSequence {
        var sequence: MusicSequence?
        NewMusicSequence(&sequence)

        var track: MusicTrack?

        var time = MusicTimeStamp(0.0)

        MusicSequenceNewTrack(sequence!, &track)

        for noteBeat in notes {
            let note = NoteToMidiMap.toMidi(note: noteBeat.note)
            let beat = BeatToTimeMap.toDuration(beat: noteBeat.beat)

            var midiNote = MIDINoteMessage(channel: 0,
                                       note: note,
                                       velocity: TrackConstants.defaultVelocity,
                                       releaseVelocity: 0,
                                       duration: 1)
            guard let track = track else {fatalError()}
            MusicTrackNewMIDINoteEvent(track, time, &midiNote)
            time += beat
        }

        var inMessage = MIDIChannelMessage(status: 0xB0, data1: 0, data2: 120, reserved: 0)
        MusicTrackNewMIDIChannelEvent(track!, 0, &inMessage)

        inMessage = MIDIChannelMessage(status: 0xB0, data1: 32, data2: 0, reserved: 0)
        MusicTrackNewMIDIChannelEvent(track!, 0, &inMessage)

//        inMessage = MIDIChannelMessage(status: 0xC0, data1: 24, data2: 0, reserved: 0)
//        var err = MusicTrackNewMIDIChannelEvent(track!, 0.0, &inMessage)

        guard let sequence = sequence else {
            fatalError()
        }

        return sequence

    }
}
