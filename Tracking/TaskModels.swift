import Foundation

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book", tasks: [
            TaskItem(title: "Submit Assignment"),
            TaskItem(title: "Prepare lecture", isCompleted: true)
        ]),
        TaskGroup(title: "The Legend of Zelda", symbolName: "gamecontroller", tasks: [
            TaskItem(title: "Get Blue Gem", isCompleted: true),
            TaskItem(title: "Defeat Ganon")
        ]),
    ]
}
