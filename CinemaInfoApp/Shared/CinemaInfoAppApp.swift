import SwiftUI
// 1. 댓글쓰기 레이아웃
// 2. 댓글 api 연결
// 3. userDefault로 첫 시작 tutorialView
// 4. 사용성 유지 디자인 수정
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
