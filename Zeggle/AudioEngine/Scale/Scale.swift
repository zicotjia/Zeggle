//
//  Scale.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

protocol Scale {
    var startingNote: Int { get }
    var pointer: Int {get set}
    static var notes: [Note] {get}

    mutating func getNextNode() -> Note
    mutating func getPreviousNode() -> Note

    mutating func buildArpeggio(of length: Int) -> [NoteBeat]
}

extension Scale {
    mutating func getNextNode() -> Note {
        pointer += 1
        if pointer == Self.notes.count {
            pointer = 0
        }
        return Self.notes[pointer]
    }

    mutating func getPreviousNode() -> Note {
        pointer -= 1
        if pointer == -1 {
            pointer = Self.notes.count - 1
        }
        return Self.notes[pointer]
    }

    mutating func buildArpeggio(of length: Int) -> [NoteBeat] {
        if length == 1 {
            return [NoteBeat(note: getNextNode(), beat: .one)]
        }
        pointer = startingNote
        var arpeggio: [NoteBeat] = []
        let half = length / 2

        if length % 2 == 0 {
            for _ in (1...half) {
                arpeggio.append(NoteBeat(note: getNextNode(), beat: .one))
            }

            for _ in ((half+1)...length) {
                arpeggio.append(NoteBeat(note: getPreviousNode(), beat: .one))
            }

            return arpeggio
        } else {
            for _ in (1...half+1) {
                arpeggio.append(NoteBeat(note: getNextNode(), beat: .one))
            }

            for _ in ((half+2)...length) {
                arpeggio.append(NoteBeat(note: getPreviousNode(), beat: .one))
            }

            return arpeggio
        }
    }
}
