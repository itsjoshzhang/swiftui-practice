import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color{
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}


struct DailyScrum: Identifiable, Codable {
    
    var id: UUID
    var title: String
    var attendees: [Attendee]
    var length: Int
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], length: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map {
            Attendee(name: $0)
        }
        self.length = length
        self.theme = theme
    }
}


extension DailyScrum {
    
    struct Attendee: Identifiable, Codable {
        var id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var length: Double = 5.0
        var theme: Theme = .seafoam
    }
    var data: Data {
        Data(title: title, attendees: attendees, length: Double(length), theme: theme)
    }
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        length = Int(data.length)
        theme = data.theme
    }
    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        length = Int(data.length)
        theme = data.theme
    }
}


struct History: Identifiable, Codable {
    
    var id: UUID
    var date: Date
    var attendees: [DailyScrum.Attendee]
    var length: Int
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], length: Int = 5) {
            self.id = id
            self.date = date
            self.attendees = attendees
            self.length = length
        }
}


extension DailyScrum {
    static var sampleData: [DailyScrum] =
    
    [DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], length: 5, theme: .yellow),
     DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], length: 5, theme: .orange),
     DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Chad"], length: 5, theme: .poppy)]
}


struct TrailingIcon: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
extension LabelStyle where Self == TrailingIcon {
    static var trailingIcon: Self {
        Self()
    }
}
