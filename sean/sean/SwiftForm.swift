import SwiftUI

struct SwiftForm: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var sendNews = false
    @State private var numLikes = 0
    @FocusState private var focus: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal info")){
                    
                    TextField("First Name", text: $firstName)
                        .focused($focus)
                    TextField("Last Name", text: $lastName)
                        .focused($focus)
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                }
                Section(header: Text("Actions")){
                    
                    Toggle("Send Newsletter", isOn: $sendNews)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                    Stepper("Number of Likes", value: $numLikes, in: 0...100)
                    Text("Likes: \(numLikes)")
                    Link("Terms of Service", destination: URL(string: "xkcd.com")!)
                }
            }
            .accentColor(.red)
            .navigationTitle("Account")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save"){
                        print("User Saved")
                    }}}}}}

struct SwiftFormTabs: View {
    var body: some View {
        TabView {
            SwiftForm()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SwiftForm()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            SwiftForm()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Cart")
                }
        }.accentColor(.red)
    }
}
struct SwiftForm_Previews: PreviewProvider {
    static var previews: some View {
        SwiftFormTabs()
    }
}
