//
//  ComplicationProvider.swift
//  ProloCounter WatchKit Extension
//
//  Created by André Prolo on 15/03/22.
//

import Foundation
import ClockKit
import SwiftUI

final class ProloCounterComplicationProvider {
    func getComplication() -> CLKComplicationTemplate {
        if let counter = JsonUtil.getValueFromKey(fileName: "Data.json", key: "counter") {
            return CLKComplicationTemplateGraphicCircularView(ComplicationViewCircular(counter: counter as! Int))
        } else {
            return getSample()
        }
    }
    
    func getSample() -> CLKComplicationTemplate {
        return CLKComplicationTemplateGraphicCircularView(ComplicationViewCircular(counter: 0))
    }
}
