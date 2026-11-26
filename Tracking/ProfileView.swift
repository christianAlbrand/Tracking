
import SwiftUI

struct ProfileView: View {
    @State private var profiles: [Profile] = Profile.sampleProfile
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)

    ]
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack {
                ScrollView {
                    VStack(spacing: 40){
                        VStack{
                            Text("Welcome to the Tracking App")
                                .font(.subheadline)
                                .textCase(.uppercase)
                                .padding(.top, 40)
                            Text("Select the Profile")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                        }
                        
                        LazyVGrid(columns: columns, spacing: 25){
                            ForEach($profiles){ $profile in
                                NavigationLink(value: profile) {
                                    ProfileCardView(profile: profile)
                                }
                                .accessibilityIdentifier("SelectProfile_\(profile.name)")
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Tracking")
            .navigationDestination(for: Profile.self) { selectedProfile in
                if let index = profiles.firstIndex(where: {$0.id == selectedProfile.id}) {
                    ContentView(profile: $profiles[index])
                }
            }
        }
    }
}

struct ProfileCardView : View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 15 ){
            ZStack {
                Image(profile.profileImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 22))
            }
            .frame(width: 120, height: 120)
            Text(profile.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.orange)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(RoundedRectangle(cornerRadius: 25)
            .fill(Color(.secondarySystemBackground))
        )
    }
}
