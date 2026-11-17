import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    var completedCount: Int { tasks.filter {$0.isCompleted}.count }
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount)/Double(tasks.count)}
    
    var body: some View{
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundStyle(Color.cyan)
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundStyle(Color.cyan)
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress*100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 60, height: 60)
            .padding()
            
            VStack {
                Text("Taks Progress")
                    .font(.headline)
                    .foregroundStyle(.brown)
                Text("\(completedCount)/\(tasks.count) Completed")
                    .font(.title2)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
