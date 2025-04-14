//
//  MSWidgetBundle.swift
//  MSWidget
//
//  Created by 강민수 on 4/7/25.
//

import WidgetKit
import SwiftUI

@main
struct MSWidgetBundle: WidgetBundle {
    var body: some Widget {
        MSWidget()
        MSWidgetControl()
        MSWidgetLiveActivity()
    }
}
