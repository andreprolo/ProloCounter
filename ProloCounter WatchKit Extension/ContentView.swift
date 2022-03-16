//
//  ContentView.swift
//  ProloCounter WatchKit Extension
//
//  Created by André Prolo on 11/03/22.
//

import SwiftUI
import ClockKit

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .foregroundColor(Color.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State private var count: Int = 0
    
    func viewDidLoad() {
        if (JsonUtil.getValueFromKey(fileName: "Data.json", key: "counter") == nil) {
            JsonUtil.persistData(fileName: "Data.json", key: "counter", value: 0)
        }
        
        self.count = JsonUtil.getValueFromKey(fileName: "Data.json", key: "counter") as! Int
    }
     
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text(#"Count: \#(count)"#)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    Button(action: handleMinusClick) {
                        Text("-")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    Button(action: handlePlusClick) {
                        Text("+")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                }.padding()
            }
        }.onAppear(perform: viewDidLoad)
    }
    
    func handlePlusClick() -> Void {
        count += 1
        JsonUtil.persistData(fileName: "Data.json", key: "counter", value: count)
        WKInterfaceDevice.current().play(.success)
        updateComplication()
    }
    
    func handleMinusClick() -> Void {
        count -= 1
        JsonUtil.persistData(fileName: "Data.json", key: "counter", value: count)
        WKInterfaceDevice.current().play(.success)
        updateComplication()
    }
    
    func updateComplication() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications ?? [] {
            guard case .graphicCircular = complication.family else { continue }
            server.reloadTimeline(for: complication)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
