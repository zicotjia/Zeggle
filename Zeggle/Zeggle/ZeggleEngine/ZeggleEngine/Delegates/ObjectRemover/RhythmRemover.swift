class RhythmRemover: ObjectRemover {
    private unowned var level: Level
    private var deletableItems: Stack<ZeggleItem> = Stack()
    private var isDeleting = false
    private var isPlaying = false
    private var set: Set<ZeggleItem> = []
    private var cMajorScale = CMajorScale()

    init(level: Level) {
        self.level = level
    }

    private func getNote() -> Note {
        return cMajorScale.getNextNode()
    }

    private func loadEntitiesForRemoval() {
        for item in level.items where item.removeFlag
        && !set.contains(item) {
            if !(item is Ball) {
                let note = cMajorScale.getNextNode()
                MyMusicPlayer.sharedInstance.playNote(noteBeat: (NoteBeat(note: note, beat: .one)))
            }
            deletableItems.push(item)
            set.insert(item)
        }
    }

    private func deleteItem() {
        guard !deletableItems.isEmpty else {
            return
        }

        isDeleting = true
        level.lockTime()

        guard let currBall = level.ball else {
            return
        }

        currBall.lockSelf()

        if !isPlaying {
            let arpeggio = cMajorScale.buildArpeggio(of: deletableItems.count)
            MyMusicPlayer.sharedInstance.playTrack(track: Track(notes: arpeggio))
            isPlaying = true
        }

        while !deletableItems.isEmpty {
            guard let currItem = deletableItems.peek() else {
                return
            }
            if !currItem.undergoingDeletion {
                currItem.startDeletion()
            }

            if !currItem.isDead {
                return
            }
            _ = deletableItems.pop()

            if currItem is Ball {
                continue
            }
            level.score += currItem.point
            level.deleteItem(zeggleItem: currItem)
        }
        set = []

        isPlaying = false
        currBall.unlockSelf()
        level.unlockTime()
        isDeleting = false
    }

    private func conditionForRemoval() -> Bool {
        guard let currentBall = level.ball else {
            return false
        }

        return currentBall.readyForRemoval() || currentBall.stuckForTooLong()
    }

    func resolve() {

        loadEntitiesForRemoval()

        guard conditionForRemoval() || isDeleting else {
            return
        }

        deleteItem()

        guard let currentBall = level.ball else {
            return
        }

        guard !isDeleting else {
            return
        }

        if currentBall.isDead {
            if !currentBall.isSpooky {
                level.removeBall()
            }
            currentBall.deletionAction()
        }

    }

    func isResolved() -> Bool {
        return deletableItems.isEmpty
    }
}
