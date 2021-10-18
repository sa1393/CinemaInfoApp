import SwiftUI
@main
struct CinemaInfoAppApp: App {
    @StateObject var baseData: BaseViewModel = BaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(baseData)
        }
    }
}
