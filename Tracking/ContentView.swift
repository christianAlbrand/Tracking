import SwiftUI

struct ContentView: View {
    
    @State private var taskGroups : [TaskGroup] = []
    
    @State private var selectedGroup: TaskGroup?
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"

    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility){
            // Column 1: sidebar
            List(selection: $selectedGroup){
                ForEach(taskGroups) { group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("TrackingApp")
            .listStyle(.sidebar)
            .toolbar{
                Button{
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id}) {
                    TaskGroupDetailview(group: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select aa Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
        .onAppear{
            loadData()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active {
                print("App is active")
            } else if newValue == .inactive {
                print("Moving to inactive")
            } else if newValue == .background {
                print("User is switching attention - SAVE DATA")
                saveData()
            }
            
        }
    }
    
    func saveData() {
        // Step A: convert our Array sWIFT -> json
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            // Step B: Save to userDefault
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        // Step A: Check if there is any content inside the key 'box'
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            // Step B: Decode the data from json -> array
            if let decodedData = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodedData
                return
            }
        }
        taskGroups = TaskGroup.sampleData
    }
}
