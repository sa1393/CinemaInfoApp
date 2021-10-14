
import Foundation

class CommentWriteViewModel: ObservableObject {
    @Published var comment: String = ""
    @Published var latingNum: Int = 0
    
    init() {
        
    }
    
}
