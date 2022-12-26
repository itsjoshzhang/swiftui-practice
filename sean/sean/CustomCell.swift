import SwiftUI

struct CustomCell: View {
    
    var videos: [Video] = VideoList.topTen
    
    var body: some View {
        NavigationStack {
            
        List(videos, id: \.id){ video in
            NavigationLink(value: video){
            
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(4)
                .padding(.vertical, 4)

        VStack(alignment: .leading, spacing: 5) {
            
            Text(video.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            
            Text(video.uploadDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        }.navigationDestination(for: Video.self) { video in
        InnerCell(video: video)
        }
        }.navigationTitle("Top 10 Videos")
        }
    }
}

struct InnerCell: View {
    var video: Video
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(12)
            
            Text(video.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text(video.description)
                .font(.body).padding()
            Spacer()
            
            Link(destination: video.url, label: {
                
                Text("Watch now")
                    .bold().font(.title2)
                    .frame(width: 280, height: 50)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
    }
}
struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomCell()
    }
}
