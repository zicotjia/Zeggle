enum LevelEditorStates: Equatable {
    case off
    case item(value: ItemType)
    case deletePeg

    var color: PegColor? {
        switch self {
        case .item(value: .orangePeg):
            return PegColor.orange
        case .item(value: .bluePeg):
            return PegColor.orange
        default:
            return nil
        }
    }

    var image: String? {
        switch self {
        case .item(value: .orangePeg):
            return ImageNameToFile.orangePeg
        case .item(value: .bluePeg):
            return ImageNameToFile.bluePeg
        default:
            return nil
        }
    }

}
