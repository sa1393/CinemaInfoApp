//
//  SignTextField.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/10/07.
//

import SwiftUI
import Combine

struct SignTextField: View {
    var placeHolder: String
    var secure: Bool
    @State var isTapped: Bool = false
    
    @Binding var text: String
    var body: some View {
        VStack {
            
            HStack {
                
                TextField("", text: $text) { (status) in
                    if status {
                        withAnimation(.easeInOut.speed(1.5)) {
                            isTapped = true
                        }
                    }
                } onCommit: {
                    if text == "" {
                        withAnimation(.easeInOut.speed(1.5)) {
                            isTapped = false
                        }
                    }
                }
                .placeHolder(hint: Text(placeHolder)
                                .foregroundColor(isTapped ? Color.white : Color.gray)
                                .scaleEffect(isTapped ? 0.6 : 1, anchor: .leading)
                                .offset(y: isTapped ? -20 : 0)
                                
                )
                .font(.system(size: 20))
                .padding(.horizontal, 12)
                .foregroundColor(Color.white)
            }
        }
        .frame(height: 60)
        .background(isTapped ? Color(hex: "#464646") : Color(hex: "#323232"))
        .cornerRadius(6.0)
    }
}



struct SignTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(TutorialViewModel())
    }
}
