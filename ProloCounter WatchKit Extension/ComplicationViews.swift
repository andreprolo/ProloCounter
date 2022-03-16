//
//  ComplicationViews.swift
//  ProloCounter WatchKit Extension
//
//  Created by André Prolo on 15/03/22.
//

import SwiftUI
import ClockKit

struct ComplicationViewCircular: View {
    @State var counter: Int

  var body: some View {
    ZStack {
        Text(#"\#(counter)"#)
            .font(.title)
            .fontWeight(.bold)
    }
  }
}


struct ComplicationViews_Previews: PreviewProvider {
    static var previews: some View {
        // 1
        Group {
          // 2
          CLKComplicationTemplateGraphicCircularView(
            ComplicationViewCircular(counter: 0)
          // 3
          ).previewContext()
        }

    }
}
