import SwiftUI

// Use @State for simple properties that belong to a single view. They should usually be marked private.
// Use $ before a property for two-way bindings. The view can read this property and the user can write it.
// Use @ObservedObject for complex properties that might belong to several views. Most times you’re using a reference type.
// Use @StateObject once for each observable object you use, in whichever part of your code is responsible for creating it.
// Use @EnvironmentObject for properties that were created elsewhere in the app, such as public shared data.
// @Published is attached to properties, and refreshes any views that use this property when it is changed.

struct ObjectWrap: View {
    
    @State private var tapCount = 0
    @State private var username = "Saira"
    
    var body: some View {
        VStack {
            Button("\(username)'s Tap count: \(tapCount)") {
                tapCount += 1
            }
            TextField("Username", text: $username)
                .padding()
        }
    }
}

// Our observable object class
class Player: ObservableObject {
    
    @Published var name = "Saira"
    @Published var age = 17
}
// A view that creates and owns the Player object.
// Creates the Player object, and places it into the environment for the navigation stack.
struct ObjectWrap2: View {
    @StateObject var player = Player()
    
    var body: some View {
        NavigationStack {
            VStack {
                // A button that writes to the environment settings
                Button("Increase Age") {
                    player.age += 1
                }
                NavigationLink {
                    ObjectWrap2_A(player: player)
                } label: {
                    Text("Show detail view")
                }
            }.environmentObject(player)
        }
    }
}
// A view that monitors the Player object for changes, but doesn't own it.
// Expects to find a Player object in the environment, and shows its score.
struct ObjectWrap2_A: View {
    
    @ObservedObject var player: Player
    @EnvironmentObject var playerE: Player

    var body: some View {
        Text("Hello, \(player.name)!")
        Text("Age: \(player.age)")
    }
}


struct ObjectWrap_Previews: PreviewProvider {
    static var previews: some View {
        ObjectWrap()
        ObjectWrap2()
    }
}
