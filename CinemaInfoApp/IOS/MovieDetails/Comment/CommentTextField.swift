//
//  CommentTextFile.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/10/14.
//

import SwiftUI

struct CommentTextField: View {
    @State var isTapped: Bool = false
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
        
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
        CommentWrite(movie: exampleMovie1)
    }
}
