//
//  CheckboxStyle.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)

                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            
            configuration.label
        }
    }
}

#Preview {
    Toggle("Placeholder label", isOn: .constant(true))
        .toggleStyle(CheckboxStyle())
        .padding()
        .previewLayout(.sizeThatFits)
}
