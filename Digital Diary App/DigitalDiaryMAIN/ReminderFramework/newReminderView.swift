//
//  newReminderView.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/17/22.
//

import SwiftUI
import UserNotificationsUI

struct newReminderView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State var name: String
    @State var notes: String
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var useTime = false
    @State private var useEndDate = false
    @State var timeInterval: Double = 1
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 15)
            ZStack {
                HStack {
                    
                    Spacer()
                        .frame(width:15)
                    
                    Button(action:
                            {
                        info.newReminderSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Cancel").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                    
                    Button(action:
                        {
                        getNotificationStatus()
                        let newReminder = Reminder(name: name, startDate: startDate, endDate: endDate, notes: notes, priority: info.prioritites.firstIndex(of: info.selectedPriority) ?? 0, useTime: useTime, useEndDate: useEndDate)
                    
                        info.reminderList.append(newReminder)
                        info.newReminderSheet.toggle()
                        
                        let content = UNMutableNotificationContent()
                        content.title = newReminder.name
                        content.subtitle = newReminder.notes
                        
                        content.sound = UNNotificationSound.default
                        // tester notif
                        //UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: newReminder.id.uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)))
                        
                        // real notif
                        if newReminder.startDate.timeIntervalSinceNow > 0 {
                            UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: newReminder.id.uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: newReminder.startDate.timeIntervalSinceNow, repeats: false)))
                        }
                        else {
                            UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: newReminder.id.uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: false)))
                        }
                        
                        
                        info.reminderList = info.reminderList.sorted(by: {
                            $0.startDate < $1.startDate
                        })
                        
                        dismiss()
                    },
                           label:
                            {
                        Text("Done").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                        .frame(width:15)
                }
                
                Text("New Reminder")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
            }
            
            
            
            Spacer()
                .frame(height:10)
            
            Form {
                Section{
                    TextField("Event", text: $name)
                    TextField("Notes", text: $notes)
                }
                Section{
                    HStack {
                        Text("Priority:")
                        Spacer()
                        Picker("Priority", selection: $info.selectedPriority){
                            ForEach(info.prioritites, id: \.self){
                                Text($0)
                            }
                            
                        }
                        .pickerStyle(.menu)
                    }
                }
                Section{
                    DatePicker("Date", selection: $startDate, displayedComponents: .date)
                    Toggle("Set Time", isOn: $useTime)
                    if useTime{
                        DatePicker("Time", selection: $startDate, displayedComponents: .hourAndMinute)
                    }
                }
                Section{
                    Toggle("Set End Date", isOn: $useEndDate)
                    if useEndDate{
                        DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                        if useTime{
                            DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                
                
            }
            .interactiveDismissDisabled()
            
            
            
            
            
        }
        
    }
    
    func getNotificationStatus()
    {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        {
            success, error in
            
            if success
            {
                print("All set!")
            }
            
            else if let error = error
            {
                print(error.localizedDescription)
            }
        }
    }
}

