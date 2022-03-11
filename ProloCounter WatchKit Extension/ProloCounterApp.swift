//
//  ProloCounterApp.swift
//  ProloCounter WatchKit Extension
//
//  Created by André Prolo on 11/03/22.
//

import SwiftUI

@main
struct ProloCounterApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
