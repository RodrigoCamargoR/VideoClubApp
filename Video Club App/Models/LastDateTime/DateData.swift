//
//  DateData.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/5/21.
//

import Foundation
import RealmSwift

class DateData: Object {
    @objc dynamic var date: String = ""
    
    func dateToString(_ date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let datetime = "\(day)/\(month)/\(year) \(hour):\(minutes)"
        
        return datetime
    }
    
    func stringToDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let newDate = formatter.date(from: date)
        return newDate!
    }
    
}
