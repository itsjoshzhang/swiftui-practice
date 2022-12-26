import SwiftUI

struct SlotsView: View {
    
    @State var credits = 100
    @State var slot1 = "slot1"
    @State var slot2 = "slot2"
    @State var slot3 = "slot3"
    
    var body: some View {
        VStack {
            Spacer()
            Text("SwiftUI Slots!")
                .font(.largeTitle)
            Spacer()
            Text("Credits: \(credits)")
            Spacer()
            
            HStack {
                Image(slot1).resizable().aspectRatio(contentMode: .fit)
                Image(slot2).resizable().aspectRatio(contentMode: .fit)
                Image(slot3).resizable().aspectRatio(contentMode: .fit)
            }
            Spacer()
            
            Button(action: {
                let rand1 = Int.random(in: 1...3)
                let rand2 = Int.random(in: 1...3)
                let rand3 = Int.random(in: 1...3)
                
                slot1 = "slot\(rand1)"
                slot2 = "slot\(rand2)"
                slot3 = "slot\(rand3)"
                
                if rand1 == rand2 && rand2 == rand3 {
                    credits += 100
                } else if credits == 0 {
                    print("Out of credits")
                } else {
                    credits -= 20
                }
            }, label: {
                Text("Spin")
                    .foregroundColor(.white)
                    .padding(.horizontal, 40.0)
                    .padding(.vertical, 10.0)
                    .background(.pink)
                    .cornerRadius(30.0)
            })
            Spacer()
        }
    }
}
struct SlotsView_Previews: PreviewProvider {
    static var previews: some View {
        SlotsView()
    }
}
