//
//  SearchTextFieldStyle.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/06/17.
//

import Foundation
import SwiftUI

struct SearchTextFieldStyle: TextFieldStyle{
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.init(hex: "7f7f7e"))
            .cornerRadius(5.0)
            .font(.system(size: 15, weight: .medium, design: .serif))
            .foregroundColor(.white)
    }
    
    
}
