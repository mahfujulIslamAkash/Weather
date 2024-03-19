//
//  Date+Extension.swift
//  Weather
//
//  Created by Appnap Mahfuj on 19/3/24.
//

import Foundation

extension Date {
//    var millisecondsSince1970:Int {
//        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
//    }
//
//    init(milliseconds:Int) {
//        self =  Date(timeIntervalSince1970: TimeInterval(milliseconds))
//        // milliseconds/1000
//    }
    static func getDateFrom(miliSec: Int) -> String {
        let date = Date(timeIntervalSince1970: (1710838032 / 1000.0))
        return getTodaysDate(date: date)
    }
    static func getTodaysDate(date: Date = Date()) -> String {
//        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    static func getHourFrom(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        var string = dateFormatter.string(from: date)
        if string.last == "M" {
            string = String(string.prefix(string.count - 3))
        }
        return string
    }
    
    static func getDayOfWeekFrom(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        var string = dateFormatter.string(from: date)
        if let index = string.firstIndex(of: ",") {
            string = String(string.prefix(upTo: index))
            return string
        }
        return "error"
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
