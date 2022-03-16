//
//  JsonUtil.swift
//  ProloCounter WatchKit Extension
//
//  Created by André Prolo on 14/03/22.
//

import Foundation

class JsonUtil {
    private static let fm: FileManager = FileManager.default
    private static let url: URL? = fm.urls(for: .documentDirectory, in: .userDomainMask).first
    
    static func persistData(fileName: String, key: String, value: Any) -> Void {
        let fileUrl = url?.appendingPathComponent(String(fileName.split(separator: ".").first!))
            .appendingPathExtension(String(fileName.split(separator: ".").last!))
        
        let jsonData: [String: Any] = [key: value]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            try data.write(to: fileUrl!, options: [.atomicWrite])
        } catch {
            print("JsonUtil: Failed to persist data")
        }
    }
    
    static func getValueFromKey(fileName: String, key: String) -> AnyObject? {
        let fileUrl = url?.appendingPathComponent(String(fileName.split(separator: ".").first!))
            .appendingPathExtension(String(fileName.split(separator: ".").last!))
        
        var result: AnyObject?
        
        do {
            let data = try Data(contentsOf: fileUrl!)
            let jsonResult = (try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])) as? Dictionary<String, AnyObject>
            result = jsonResult?[key]
        } catch {
            print("JsonUtil: Failed to get data")
        }
        
        return result
    }
}
