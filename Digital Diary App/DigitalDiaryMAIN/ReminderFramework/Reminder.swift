//
//  Reminder.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/17/22.
//

import Foundation


struct Reminder: Identifiable
{
    
    var id = UUID()
    var name: String
    var startDate: Date
    var endDate: Date
    var notes: String
    var priority: Int
    var useTime: Bool
    var useEndDate: Bool
    
}
