
import Foundation
import SwiftUI

struct PlaceHolder<T: View>: ViewModifier {
    var hint: T
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            hint
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(hint: T) -> some View {
        self.modifier(PlaceHolder(hint: hint))
    }
}
