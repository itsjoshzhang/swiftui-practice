import SwiftUI

struct CityView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("toronto")
                    .resizable().aspectRatio(contentMode: .fit)
                    .cornerRadius(10).padding()
                    
                VStack {
                    Text("CN Tower")
                        .font(.largeTitle)
                    Text("Toronto")
                        .font(.caption2)
                }
                    .foregroundColor(.white)
                    .padding().background(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
            }
            ZStack {
                Image("london")
                    .resizable().aspectRatio(contentMode: .fit)
                    .cornerRadius(10).padding()
                
                VStack {
                    Text("Big Ben")
                        .font(.largeTitle)
                    Text("London")
                        .font(.caption2)
                }
                    .foregroundColor(.white)
                    .padding().background(.black)
                    .cornerRadius(10)
                    .opacity(0.8)
            }
        }
    }
}
struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
