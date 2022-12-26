import SwiftUI

struct MeetingView: View {
    
    @Binding var scrum: DailyScrum
    @StateObject var timer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                HeaderView(elapsed: timer.secondsElapsed,
                           remaining: timer.secondsRemaining,
                           theme: scrum.theme)
                Circle()
                    .strokeBorder(lineWidth: 24)
                FooterView(speakers: timer.speakers,
                           skipAction: timer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            timer.reset(length: scrum.length,
                        attendees: scrum.attendees)
            timer.startScrum()
        }
        .onDisappear {
            timer.stopScrum()
            let newHistory = History(attendees: scrum.attendees,
                length: scrum.timer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct HeaderView: View {
    
    var elapsed: Int
    var remaining: Int
    var theme: Theme
    
    private var total: Int {
        elapsed + remaining
    }
    private var progress: Double {
        guard total > 0 else {
            return 1
        }
        return Double(elapsed) / Double(total)
    }
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgress(theme: theme))
            HStack {
                VStack(alignment: .leading){
                    Text("Seconds elapsed")
                        .font(.caption)
                    Label("\(elapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack (alignment: .trailing){
                    Text("Seconds remaining")
                        .font(.caption)
                    Label("\(remaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }.padding([.top, .horizontal])
    }
}


struct FooterView: View {
    
    var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    private var speakerNum: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else {
            return nil
        }
        return index + 1
    }
    private var lastSpeaker: Bool {
        return speakers.dropLast().allSatisfy {
            $0.isCompleted
        }
    }
    private var speakerText: String {
        guard let speakerNum = speakerNum else {
            return "No more speakers"
        }
        return "Speaker \(speakerNum) of \(speakers.count)"
    }
    var body: some View {
        VStack {
            HStack {
                if lastSpeaker {
                    Text("Last speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction){
                        Image(systemName: "forward.fill")
                    }
                }
            }
        }.padding([.top, .horizontal])
    }
}


struct ScrumProgress: ProgressViewStyle {
    var theme: Theme

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            
            ProgressView(configuration)
                .tint(theme.mainColor)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}
struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
