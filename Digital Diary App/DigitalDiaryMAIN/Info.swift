//
//  Info.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/14/22.
//

import Foundation
import UIKit

class Info: ObservableObject
{
    //Reminder Resources
    @Published var reminderList: [Reminder] = [].sorted(by: {
        $0.startDate < $1.startDate
    })
    @Published var reminderStore = Reminder(name: "", startDate: Date(), endDate: Date(), notes: "", priority: 0, useTime: false, useEndDate: false)
    @Published var selectedPriority = "None"
    @Published var prioritites = ["None", "Low", "Medium", "High"]
    @Published var newReminderSheet = false
    @Published var editReminderSheet = false
    
    //Contact Resources
    @Published var transparent = UIImage(systemName: "transparent")
    @Published var contactList: [Contact] = [].sorted(by: {
        $0.lastName < $1.lastName
    })
    @Published var contStore: Contact = Contact(firstName: "", lastName: "", phoneNum: "", email: "", address: "", birthday: Date(), notes: "", isFavorite: false)
    @Published var newContSheet = false
    @Published var editContSheet = false
    
}
