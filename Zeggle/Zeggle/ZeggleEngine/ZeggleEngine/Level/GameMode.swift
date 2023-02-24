enum GameMode: String, Identifiable, CaseIterable {
    case standard
    case timeAttack
    case beatTheScore
    case dodgeBall

    var id: GameMode { self }
}
