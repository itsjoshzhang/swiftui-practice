import SwiftUI

struct ListView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var showNew = false
    @State private var newData = DailyScrum.Data()
    var saveAction: ()-> Void
    
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Meetings")
        .toolbar {
            Button(action: {
                showNew = true
            }){
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showNew) {
        NavigationStack {
        EditView(data: $newData)
        .toolbar {

        ToolbarItem(placement: .cancellationAction) {
            Button("Dismiss") {
                showNew = false
                newData = DailyScrum.Data()
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Add") {
                let newScrum = DailyScrum(data: newData)
                scrums.append(newScrum)
                showNew = false
                newData = DailyScrum.Data()
            }}}}}
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}


struct CardView: View {
    var scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(scrum.title)
                .font(.headline)
                .padding(.bottom, 1)
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                Spacer()
                Label("\(scrum.length)", systemImage: "clock")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .background(scrum.theme.mainColor)
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
