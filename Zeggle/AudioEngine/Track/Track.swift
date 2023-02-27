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

        guard let sequence = sequence else {
            fatalError()
        }

        return sequence

    }
}
