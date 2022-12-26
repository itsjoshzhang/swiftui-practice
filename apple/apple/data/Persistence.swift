import SwiftUI

// 1. Add Codable conformance to:
// enum Theme, struct History, struct DailyScrum, struct Attendee

class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    
    
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            }
        }
    }
    static func load(completion: @escaping (Result<[DailyScrum], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(scrums: scrums) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrumsSaved):
                    continuation.resume(returning: scrumsSaved)
                }
            }
        }
    }
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }}}}}


// 2. Completely change appleApp:
 
 struct appleApp_COPY: App {
     @StateObject private var store = ScrumStore()
     @State private var errorWrapper: ErrorWrapper?
     
     var body: some Scene {
         WindowGroup {
             NavigationView {
                 ListView(scrums: $store.scrums) {
                     Task {
                         do {
                             try await ScrumStore.save(scrums: store.scrums)
                         } catch {
                             errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                         }
                     }
                 }
             }
             .task {
                 do {
                     store.scrums = try await ScrumStore.load()
                 } catch {
                     errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                 }
             }
             .sheet(item: $errorWrapper, onDismiss: {
                 store.scrums = DailyScrum.sampleData
             }) { wrapper in
                 ErrorView(errorWrapper: wrapper)
             }
         }
     }
 }

/*
 4. Add properties to ListView:
 
 @Environment(\.scenePhase) private var scenePhase
 var saveAction: ()-> Void

 5. Add modifier to List in ListView:
    .onChange(of: scenePhase) { phase in
        if phase == .inactive { saveAction() }
    }
 ...
    ListView(...saveAction: {})

6. Create ErrorView file with code
 */
