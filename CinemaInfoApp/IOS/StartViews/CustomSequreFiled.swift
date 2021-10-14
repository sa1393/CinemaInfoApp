//
//  CustomSequreFiled.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/10/13.
//

import SwiftUI

struct CustomSequreFiled: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextField("", text: $text) { (status) in
                if status {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isTapped = true
                    }
                }
            } onCommit: {
                if text == "" {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isTapped = false
                    }
                }
            }
        }
    }
}

struct CustomSequreFiled_Previews: PreviewProvider {
    static var previews: some View {
        CustomSequreFiled()
    }
}
