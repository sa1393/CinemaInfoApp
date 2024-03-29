import SwiftUI

struct ReviewTextField: View {
    @Binding var text: String
    @Binding var isTapped: Bool
    
    init(text: Binding<String>, isTapped: Binding<Bool>) {
        self._text = text
        self._isTapped = isTapped
        print(isTapped.wrappedValue)
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .onChange(of: text, perform: { value in
                    if value != "" {
                        withAnimation(.easeInOut.speed(1.5)) {
                            isTapped = true
                        }
                    }
                    else {
                        isTapped = false
                    }
                })
                .placeHolder(hint: Text(isTapped ? "" : "감상평을 써주세요.").padding(.leading, 8).offset(y: -42).padding(.bottom, 4).foregroundColor(Color.gray))
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .font(.system(size: 18))
                .lineSpacing(1)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                .cornerRadius(12)
                .background(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isTapped ? Color.white : Color.gray, lineWidth: 2)
                )
        }

    }
}

struct CommentTextFile_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ReviewWrite(movie: exampleMovie1), dark: true)
            .environmentObject(BaseViewModel())
    }
}
