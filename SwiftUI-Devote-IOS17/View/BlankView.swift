//
//  BlankView.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

struct BlankView: View {
    //MARK: - Properties
    var backgroundColor: Color
    var backgroundOpacity: Double
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradinet.ignoresSafeArea(.all))
}
