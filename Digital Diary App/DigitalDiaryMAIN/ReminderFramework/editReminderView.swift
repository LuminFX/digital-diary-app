//
//  editReminderView.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/17/22.
//

import SwiftUI

struct editReminderView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State var reminder: Reminder
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var useTime = false
    @State private var useEndDate = false
    
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
                        info.editReminderSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Cancel").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                    
                    Button(action:
                        {
                        reminder.priority = info.prioritites.firstIndex(of: info.selectedPriority) ?? 0
                        if let index = info.reminderList.firstIndex(where: {$0.id == reminder.id}){
                            
                            info.reminderList[index] = reminder
                            
                        }
                        info.reminderList = info.reminderList.sorted(by: {
                            $0.startDate < $1.startDate
                        })
                        info.editReminderSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Done").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                        .frame(width:15)
                }
                
                Text("Edit Reminder")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
            }
            
            
            
            Spacer()
                .frame(height:10)
            
            Form {
                Section{
                    TextField("Event", text: $reminder.name)
                    TextField("Notes", text: $reminder.notes)
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
                    DatePicker("Date", selection: $reminder.startDate, displayedComponents: .date)
                    Toggle("Set Time", isOn: $reminder.useTime)
                    if reminder.useTime{
                        DatePicker("Time", selection: $reminder.startDate, displayedComponents: .hourAndMinute)
                    }
                }
                Section{
                    Toggle("Set End Date", isOn: $reminder.useEndDate)
                    if reminder.useEndDate{
                        DatePicker("End Date", selection: $reminder.endDate, displayedComponents: .date)
                        if reminder.useTime{
                            DatePicker("End Time", selection: $reminder.endDate, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                
                
            }
            
            
            
            
            
        }
        .interactiveDismissDisabled()
    }
}
