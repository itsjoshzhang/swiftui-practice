import SwiftUI

class Pictures: ObservableObject {
    @Published var photos = ["1", "2", "3", "4", "5", "6",]
}
struct DynamicList: View {
    @StateObject var pictures = Pictures()
    
    var body: some View {
        NavigationStack {
            List(pictures.photos, id: \.self) { photo in
                NavigationLink(value: photo){
                    Text("Photo \(photo)")
                }
                .navigationDestination(for: String.self) { photo in
                    DetailView(image: photo)
                }
            }.navigationTitle(Text("Wallpapers"))
        }
    }
}
struct DetailView: View {
    @State private var hideNav = false
    var image: String
    
    var body: some View {
        Image(image)
            .resizable().aspectRatio(contentMode: .fit)
            .navigationBarTitle(Text("Photo \(image)"), displayMode: .inline)
            .navigationBarHidden(hideNav)
            .onTapGesture {
                self.hideNav.toggle()
            }
    }
}


struct LazyGrids: View {
    
    var data = Array(1...100).map { "Item \($0)" }
    //var layout = [GridItem(.adaptive(minimum: 80))]
    //var layout = [GridItem(.flexible(maximum: 80))]
    var layout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
        //  LazyHGrid(rows:
            LazyVGrid(columns: layout, spacing: 20){
        //  ForEach(array...            name in
            ForEach(data, id: \.self) { item in
                VStack {
                Capsule()
                    .fill(.blue)
                    .frame(height: 20)
                Text(item)
                    .foregroundColor(.secondary)
                }
                }.padding(.horizontal)
                }
            }.navigationTitle("LazyGrids")
        }
    }
}
struct DynamicList_Previews: PreviewProvider {
    static var previews: some View {
        DynamicList()
        LazyGrids()
    }
}
