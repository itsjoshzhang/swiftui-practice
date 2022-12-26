import SwiftUI

struct ResultView: View {
    var choice: String
    
    var body: some View {
        Text("You chose \(choice)")
    }
}
struct Navigation: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                NavigationLink(destination: Text("Second view")) {
                    Image("logo")
                        .renderingMode(.original)
                        // original color vs template blue
                }
                Text("Heads or tails?")
                NavigationLink(destination: ResultView(choice: "heads")) {
                    Text("Choose heads")
                }
                NavigationLink(destination: ResultView(choice: "tails")) {
                    Text("Choose tails")
                }
            }.navigationBarTitle("Navigation", displayMode: .automatic)
        } // attached to content, not NavigationView
    }
}


struct HideNavigationBool: View {
    @State private var showing = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                NavigationLink(destination: Text("Second view"), isActive: $showing) {
                    EmptyView()
                }
                Button("Tap to show detail") {
                    self.showing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showing = false
                    }
                }
            }.navigationBarTitle("HideNavigationBool")
        }
    }
}


struct HideNavigationTags: View {
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                NavigationLink(destination: Text("Second view"), tag: "Second", selection: $selection) { EmptyView()}
                NavigationLink(destination: Text("Third view"), tag: "Third", selection: $selection) { EmptyView()}
                
                Button("Tap to show second view") {
                    self.selection = "Second"
                }
                Button("Tap to show third view") {
                    self.selection = "Third"
                }
                .navigationBarTitle("HideNavigationTags")
            }
        }
    }
}


class User: ObservableObject {
    @Published var score = 0
}
struct ChangeView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("Score: \(user.score)")
            Button("Increase") {
                self.user.score += 1
            }
        }
    }
}
struct ChangeNavigation: View {
    @ObservedObject var user = User()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Text("Score: \(user.score)")
                NavigationLink(destination: ChangeView()){
                    Text("Show detail view")
                }
            }.navigationBarTitle("ChangeNavigation")
        }.environmentObject(user)
    }// attached to NavigationView, not just content
}


struct NavigationButtons: View {
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            Text("Score: \(score)")
                .navigationBarTitle("NavigationButtons")
                .navigationBarItems(
                    leading:
                        Button("Increase"){
                            self.score += 1
                        },
                    trailing:
                        Button("Decrease"){
                            self.score -= 1
                    })
        }
    }
}


struct FullscreenNav: View {
    @State private var fullscreen = false
    
    var body: some View {
        NavigationView {
            
            Button("Toggle fullscreen") {
                self.fullscreen.toggle()
            }
            .navigationBarTitle("FullscreenNav")
            .navigationBarHidden(fullscreen)
        }
        .statusBar(hidden: fullscreen)
    }
}


struct LandscapeNav: View {
    var body: some View {
        NavigationView {
            
            Text("Primary")
                .navigationBarTitle("Primary")
            Text("Secondary")
        } // want default split view ^
        .navigationViewStyle(StackNavigationViewStyle())
    } // don't want default split view ^
}


struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
//        HideNavigationTags()
//        HideNavigationBool()
//        ChangeNavigation()
//        NavigationButtons()
//        FullscreenNav()
//        LandscapeNav()
    }
}
