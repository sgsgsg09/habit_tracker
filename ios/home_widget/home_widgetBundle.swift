//
//  home_widgetBundle.swift
//  home_widget
//
//  Created by pc on 3/29/25.
//

import WidgetKit
import SwiftUI

@main
struct home_widgetBundle: WidgetBundle {
    var body: some Widget {
        home_widget()
        home_widgetControl()
        home_widgetLiveActivity()
    }
}
