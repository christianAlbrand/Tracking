import Foundation

struct TaskItem: Identifiable, Hashable, Encodable, Decodable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Encodable, Decodable{
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
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

extension Profile {
    static let sampleProfile: [Profile] = [
        Profile(name:"Professor", profileImage: "professorProfile", groups: TaskGroup.sampleData),
        Profile(name:"Student", profileImage: "studentProfile", groups: []),
    ]
    
}
