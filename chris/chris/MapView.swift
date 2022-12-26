import SwiftUI
import MapKit

struct MapView_Previews: PreviewProvider {
    
    private var scope = 0
    // private (can't be accessed outside of structure)
    
    @State var state = 0
    // @State (can be changed inside of View structure)
    
    static var previews: some View {
        // static (shared by all instances of structure)
        Group {
            MapView()
            // create instance of MapView structure
            
                .preferredColorScheme(.light)
                // call PCS method on MapView instance
        }
    }
}
// struct StructureName: Protocol (set of rules)
struct MapView: View {
    // View protocol -> body property that returns View
    
    // var name: some Protocol
    var body: some View {
        // View protocol -> must return View instance
            
        VStack {
            MapView2()
                .ignoresSafeArea(edges: .top)
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.largeTitle)

                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }
                .foregroundColor(.secondary)

                Divider()

                Text("About Turtle Rock")
                    .font(.headline)
                Text("Descriptive text goes here.")
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}
struct MapView2: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011, longitude: -116.167),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}
struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
            .overlay(Circle()
            .stroke(.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}
