//
//  Beat.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

enum Beat: String {
    case half
    case one
    case two
    case four
}

class BeatToTimeMap {
    static let beatToTimeMap: [Beat: Double] = {
        var map: [Beat: Double] = [:]
        map[Beat.half] = 0.5
        map[Beat.one] = 1.0
        map[Beat.two] = 2.0
        map[Beat.four] = 4.0
        return map
    }()

    static func toDuration(beat: Beat) -> Double {

        guard let duration = beatToTimeMap[beat] else {
            fatalError()
        }

        return duration
    }
}
