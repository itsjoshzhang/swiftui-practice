import SwiftUI

struct DetailView: View {
    
    @Binding var scrum: DailyScrum
    @State private var data = DailyScrum.Data()
    @State private var showEdit = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")){
                
                NavigationLink(destination: MeetingView(scrum: $scrum)){
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.length) minutes")
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")){
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar")
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit"){
                showEdit = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $showEdit){
            NavigationStack {
            EditView(data: $data)
            .navigationTitle(scrum.title)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        showEdit = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done"){
                        showEdit = false
                        scrum.update(from: data)
                    }}}}}}}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
