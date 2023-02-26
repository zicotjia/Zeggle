//
//  NotesToMidiNumber.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

enum Note: CaseIterable {
    case E2
    case F2
    case G2
    case A2
    case B2
    case C3
    case D3
    case E3
    case F3
    case G3
    case A3
    case B3
    case C4
    case D4
    case E4
    case F4
    case G4
}

class NoteToMidiMap {
    static let noteToMidiMap: [Note: UInt8] = {
        var map: [Note: UInt8] = [:]
        map[Note.E2] = 40
        map[Note.F2] = 41
        map[Note.G2] = 43
        map[Note.A2] = 45
        map[Note.B2] = 47
        map[Note.C3] = 48
        map[Note.D3] = 50
        map[Note.E3] = 52
        map[Note.F3] = 53
        map[Note.G3] = 55
        map[Note.A3] = 57
        map[Note.B3] = 59
        map[Note.C4] = 60
        map[Note.D4] = 62
        map[Note.E4] = 64
        map[Note.F4] = 65
        map[Note.G4] = 67
        return map
    }()

    static func toMidi(note: Note) -> UInt8 {
        guard let midiNote = noteToMidiMap[note] else {
            fatalError()
        }
        return midiNote
    }
}
