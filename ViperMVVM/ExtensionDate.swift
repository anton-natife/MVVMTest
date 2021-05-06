//
//  ExtensionDate.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 05.05.2021.
//

import Foundation

extension Date {
    
    func amountMinutsFrom() -> String {
        let currentDate = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: currentDate)
        
        if let year = components.year {
            return year.description + " год"
        }
        if let month = components.month {
            return month.description + " месяцев"
        }
        if let day = components.day {
            return day.description + " дней"
        }
        if let hour = components.hour {
            return hour.description + " часов"
        }
        if let minute = components.minute {
            return minute.description + " минут"
        }

        return "no date"
    }
}
