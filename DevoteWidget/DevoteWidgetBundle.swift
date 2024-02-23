//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by Daniel Felipe on 20/02/24.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
    var body: some Widget {
        DevoteWidget()
        DevoteWidgetLiveActivity()
    }
}
