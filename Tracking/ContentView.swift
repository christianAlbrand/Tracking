import SwiftUI

struct ContentView: View {
    
    @State private var taskGroups = TaskGroup.sampleData
    
    @State private var selectedGroup: TaskGroup?
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    @State private var isShowingAddGroup = false

    
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
    }
}
