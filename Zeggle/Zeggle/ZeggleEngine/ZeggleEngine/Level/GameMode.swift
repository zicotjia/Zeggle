enum GameMode: String, Identifiable, CaseIterable {
    case standard = "Standard"
    case timeAttack = "Time Attack"
    case beatTheScore = "Beat the Score"
    case dodgeBall = "Dodge Ball"

    var id: GameMode { self }
}
