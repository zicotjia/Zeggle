struct Stack<T> {

    private(set) var elements: [T] = []

    /// Adds an element to the top of the stack.
    /// - Parameter item: The element to be added to the stack
    mutating func push(_ item: T) {
        elements.append(item)
    }

    /// Removes the element at the top of the stack and return it.
    /// - Returns: element at the top of the stack
    mutating func pop() -> T? {
        elements.popLast()
    }

    /// Returns, but does not remove, the element at the top of the stack.
    /// - Returns: element at the top of the stack
    func peek() -> T? {
        elements.last
    }

    /// The number of elements currently in the stack.
    var count: Int {
        elements.count
    }

    /// Whether the stack is empty.
    var isEmpty: Bool {
        elements.isEmpty
    }

    /// Removes all elements in the stack.
    mutating func removeAll() {
        elements.removeAll()
    }

    /// Returns an array of the elements in their respective pop order, i.e.
    /// first element in the array is the first element to be popped.
    /// - Returns: array of elements in their respective pop order
    func toArray() -> [T] {
        [T](elements.reversed())
    }

}
