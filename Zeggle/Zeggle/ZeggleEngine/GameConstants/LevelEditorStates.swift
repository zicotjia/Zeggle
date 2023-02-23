enum LevelEditorStates {
    case off
    case addBluePeg
    case addOrangePeg
    case deletePeg

    var color: PegColor? {
        switch self {
        case .addBluePeg:
            return PegColor.blue
        case .addOrangePeg:
            return PegColor.orange
        default:
            return nil
        }
    }
}
