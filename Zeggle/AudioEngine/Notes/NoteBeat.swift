//
//  NoteBeat.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

class NoteBeat {
    private(set) var note: Note
    private(set) var beat: Beat

    init(note: Note, beat: Beat) {
        self.note = note
        self.beat = beat
    }
}
