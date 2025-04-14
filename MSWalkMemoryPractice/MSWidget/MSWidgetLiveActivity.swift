//
//  MSWidgetLiveActivity.swift
//  MSWidget
//
//  Created by 강민수 on 4/7/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MSWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MSWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MSWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MSWidgetAttributes {
    fileprivate static var preview: MSWidgetAttributes {
        MSWidgetAttributes(name: "World")
    }
}

extension MSWidgetAttributes.ContentState {
    fileprivate static var smiley: MSWidgetAttributes.ContentState {
        MSWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MSWidgetAttributes.ContentState {
         MSWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MSWidgetAttributes.preview) {
   MSWidgetLiveActivity()
} contentStates: {
    MSWidgetAttributes.ContentState.smiley
    MSWidgetAttributes.ContentState.starEyes
}
