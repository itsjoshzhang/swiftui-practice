import SwiftUI

struct CardsView: View {
    
    @State var playerCard = "back"
    @State var cpuCard = "back"
    @State var playerScore = 0
    @State var cpuScore = 0
    
    var body: some View {
        ZStack {
            Image("background")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                
                HStack {
                    Image(playerCard).padding()
                    Image(cpuCard).padding()
                }
                Spacer()
                
                Button(action: {
                    let playerRand = Int.random(in: 2...14)
                    let cpuRand = Int.random(in: 2...14)
                    
                    playerCard = "card\(playerRand)"
                    cpuCard = "card\(cpuRand)"
                    
                    if playerRand > cpuRand {
                        playerScore += 1
                    } else if cpuRand > playerRand {
                        cpuScore += 1
                    }
                }, label: {
                    Image("dealbutton")
                })
                Spacer()
                
                HStack {
                    VStack {
                        Text("Player")
                        Text(String(playerScore)).padding()
                    }
                    .padding()
                    
                    VStack {
                        Text("CPU")
                        Text(String(cpuScore)).padding()
                    }
                    .padding()
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                Spacer()
            }
        }
    }
}
struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardsView()
        }
    }
}
