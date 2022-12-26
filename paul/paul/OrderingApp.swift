import SwiftUI

class Order: ObservableObject {
    enum CodingKeys: String, CodingKey {
        case type, number, specials, extras, vegan, address, misc
    }
    
    static var types = ["Vanilla", "Chocolate", "Strawberry"]
    @Published var type = 0
    @Published var number = 1
    
    @Published var specials = false
    @Published var extras = false
    @Published var vegan = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var misc = ""
    
    var valid: Bool {
        if name.isEmpty || address.isEmpty || misc.isEmpty {
            return false
        }
        return true
    }
}
struct OrderingApp: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
        Form {
        Section {
            Picker(selection: $order.type, label: Text("Choose your order type")) {
                ForEach(0 ..< Order.types.count) {
                    Text(Order.types[$0]).tag($0)
                }
            }.pickerStyle(.navigationLink)
            
            Stepper(value: $order.number, in: 1...20) {
                Text("Number of orders: \(order.number)")
            }
        }
        Section {
            Toggle(isOn: $order.specials) {
                Text("Any special requests?")
            }
            if order.specials {
                Toggle(isOn: $order.extras) {
                    Text("Add extra protein")
                }
                Toggle(isOn: $order.vegan) {
                    Text("Make vegan order")
                }
            }
        }
        Section {
            TextField("Name", text: $order.name)
            TextField("Address", text: $order.address)
            TextField("City, State, Zip Code", text: $order.misc)
        }
        Section {
            NavigationLink(value: order.name){
                Text("PLACE ORDER")
            }
            .navigationDestination(for: String.self) { name in
                Text("Thank you \(name). Order placed!")
            }
        }.disabled(!order.valid)
        }.navigationBarTitle(Text("Taste Buddies"))
        }
    }
}
struct OrderingApp_Previews: PreviewProvider {
    static var previews: some View {
        OrderingApp()
    }
}
