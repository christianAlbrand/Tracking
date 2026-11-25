import SwiftUI

struct ContentView: View {
    
    @State private var taskGroups : [TaskGroup] = []
    
    @State private var selectedGroup: TaskGroup?
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile

    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility){
            // Column 1: sidebar
            List(selection: $selectedGroup){
                ForEach(profile.groups) { group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding(8)
                            .background(Circle().fill(.primary.opacity(0.1)))
                    }
                }
                ToolbarItem(placement: .primaryAction){
                    Button{
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id}) {
                    TaskGroupDetailview(group: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select aa Group", systemImage: "sidebar.left")
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
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
        if let encodedData = try? JSONEncoder().encode(profile.groups) {
            // Step B: Save to userDefault
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        // Step A: Check if there is any content inside the key 'box'
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            // Step B: Decode the data from json -> array
            if let decodedData = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                profile.groups = decodedData
                return
            }
        }
        profile.groups = TaskGroup.sampleData
    }
}
