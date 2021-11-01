//
//  Preview.swift
//  CinemaInfoApp
//
//  Created by 박태양 on 2021/10/31.
//

import SwiftUI

struct Preview<V: View>: View {
    enum Device: String, CaseIterable {
        case iPhone8Plus = "iPhone 8 Plus"
        case iPhone11 = "iPhone 11"
        case iPhone12ProMax = "iPhone 12 Pro Max"
    }
    
    let source: V
    var devices: [Device] = [.iPhone8Plus, .iPhone11, .iPhone12ProMax]
    
    var dark: Bool
    
    var body: some View {
        ForEach(devices, id: \.self) { device in
            previewSource(device: device)
        }
    }
    
    private func previewSource(device: Device) -> some View {
        self.source
            .previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
            .preferredColorScheme(dark ? .dark : .light)
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Color.blue, dark: true)
    }
}
