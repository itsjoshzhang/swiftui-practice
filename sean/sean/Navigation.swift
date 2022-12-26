import SwiftUI

struct Platform: Hashable {
    var name: String
    var color: Color
}
struct Game: Hashable {
    var name: String
    var rating: String
}
struct Navigation: View {
    
    var platforms: [Platform] = [
        .init(name: "Xbox", color: .green),
        .init(name: "PS5", color: .indigo),
        .init(name: "PC", color: .pink),
        .init(name: "Mobile", color: .mint)]
    
    var games: [Game] = [
        .init(name: "Minecraft", rating: "99"),
        .init(name: "GTA 5", rating: "98"),
        .init(name: "Tetris", rating: "97"),
        .init(name: "Wii Sports", rating: "96")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path){
            List {
                Section("Platforms"){
                    
                    ForEach(platforms, id: \.name){ platform in
                        NavigationLink(value: platform){
                            Label(platform.name, systemImage: "globe")
                                .foregroundColor(platform.color)
                        }
                    }
                }
                Section("Games"){
                    ForEach(games, id: \.name){ game in
                        NavigationLink(value: game){
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Platforms")
            .navigationDestination(for: Platform.self){ platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack {
                        Label(platform.name, systemImage: "globe")
                            .font(.largeTitle).bold()
                        List {
                            ForEach(games, id: \.name){ game in
                                
                                NavigationLink(value: game){
                                    Text(game.name)
            }}}}}}
            
            .navigationDestination(for: Game.self){ game in
                VStack(spacing: 20){
                    
                    Text("\(game.name)")
                        .font(.largeTitle).bold()
                    Text("Rating: \(game.rating)")
                    
                    Button("Recommend a Game"){
                        path.append(games.randomElement()!)
                    }
                    Button("Choose Platform"){
                        path.append(platforms.randomElement()!)
                    }
                    Button("Back to Home"){
                        path.removeLast(path.count)
            }}}}}}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
