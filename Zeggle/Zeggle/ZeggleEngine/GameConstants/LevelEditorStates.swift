enum LevelEditorStates: Equatable {
    case off
    case item(value: ItemType)
    case deletePeg

    var itemType: ItemType? {
        switch self {
        case .item(value: .orangePeg):
            return ItemType.orangePeg
        case .item(value: .bluePeg):
            return ItemType.bluePeg
        case .item(value: .zombiePeg):
            return ItemType.zombiePeg
        case .item(value: .yellowPeg):
            return ItemType.yellowPeg
        case .item(value: .redPeg):
            return ItemType.redPeg
        case .item(value: .pinkPeg):
            return ItemType.pinkPeg
        default:
            return nil
        }

    }

    var color: PegColor? {
        switch self {
        case .item(value: .orangePeg):
            return PegColor.orange
        case .item(value: .bluePeg):
            return PegColor.blue
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
        case .item(value: .pinkPeg):
            return ImageNameToFile.pinkPeg
        case .item(value: .yellowPeg):
            return ImageNameToFile.yellowPeg
        case .item(value: .redPeg):
            return ImageNameToFile.redPeg
        case .item(value: .zombiePeg):
            return ImageNameToFile.zombie
        default:
            return nil
        }
    }

}
