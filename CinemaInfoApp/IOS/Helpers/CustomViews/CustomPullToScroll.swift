
import SwiftUI

struct CustomPullToScroll: View {
    @Binding var refresh: Refresh
    
    var updateData: () -> Void
    
    var body: some View {
        GeometryReader { reader -> AnyView in
            DispatchQueue.main.async {
                if refresh.startOffset == 0 {
                    refresh.startOffset = reader.frame(in: .global).minY
                }

                refresh.offset = reader.frame(in: .global).minY

                if refresh.offset - refresh.startOffset > 80 && !refresh.started {
                    refresh.started = true
                }
                
                if refresh.startOffset == refresh.offset && refresh.started && !refresh.released {
                    refresh.released = true
                    updateData()
                }
            }
            return AnyView(Color.black.frame(width: 0, height: 0))
        }
        .frame(height: 0)
    }
}
