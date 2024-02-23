//
//  BackgroundImageView.swift
//  SwiftUI-Devote-IOS17
//
//  Created by Daniel Felipe on 20/02/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview { BackgroundImageView() }
