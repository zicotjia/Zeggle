//
//  SampleTrack.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

class SampleTrack {
    static let cMajorScale8notes = [NoteBeat(note: .C3, beat: .one),
                                    NoteBeat(note: .D3, beat: .one),
                                    NoteBeat(note: .E3, beat: .one),
                                    NoteBeat(note: .F3, beat: .one),
                                    NoteBeat(note: .F3, beat: .one),
                                    NoteBeat(note: .E3, beat: .one),
                                    NoteBeat(note: .D3, beat: .one),
                                    NoteBeat(note: .C3, beat: .one)]

    static let cMajorScale9notes = [NoteBeat(note: .C3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .C3, beat: .one)]

    static let cMajorScale10notes = [NoteBeat(note: .C3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .C3, beat: .one)]

    static let cMajorScale11notes = [NoteBeat(note: .C3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .A3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .C3, beat: .one)]

    static let cMajorScale12notes = [NoteBeat(note: .C3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .A3, beat: .one),
                                     NoteBeat(note: .A3, beat: .one),
                                     NoteBeat(note: .G3, beat: .one),
                                     NoteBeat(note: .F3, beat: .one),
                                     NoteBeat(note: .E3, beat: .one),
                                     NoteBeat(note: .D3, beat: .one),
                                     NoteBeat(note: .C3, beat: .one)]

    static let cMajorTrack8 = Track(notes: cMajorScale8notes)
    static let cMajorTrack12 = Track(notes: cMajorScale12notes)
}
