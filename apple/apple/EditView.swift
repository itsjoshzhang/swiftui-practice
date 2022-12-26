import SwiftUI

struct EditView: View {
    
    @Binding var data: DailyScrum.Data
    @State private var newName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")){
                
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.length, in: 5...60, step: 1)
                    Spacer()
                    Text("\(Int(data.length)) minutes")
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Attendees")){
                
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newName)
                            data.attendees.append(attendee)
                            newName = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                    }.disabled(newName.isEmpty)
                }}}}}


struct ThemeView: View {
    var theme: Theme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}
struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
