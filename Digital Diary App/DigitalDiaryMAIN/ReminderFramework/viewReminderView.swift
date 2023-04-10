//
//  viewReminderView.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/17/22.
//

import SwiftUI

struct viewReminderView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State var reminder: Reminder
    
    var body: some View {
        
        VStack {
        
            Spacer()
                .frame(height:15)
            
                Text(reminder.name)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            
            Spacer()
                .frame(height:10)
            
            Form {
                Section(header: Text("Time:")){
                    HStack{
                        if reminder.useTime{
                            if reminder.useEndDate{
                                Text(reminder.startDate, format: .dateTime.month().day().hour().minute())
                                Text("-")
                                Text(reminder.endDate, format: .dateTime.month().day().hour().minute())
                            }
                            else{
                                Text(reminder.startDate, format: .dateTime.month().day().hour().minute())
                            }
                        }
                        else{
                            if reminder.useEndDate{
                                Text(reminder.startDate, format: .dateTime.month().day())
                                Text("-")
                                Text(reminder.endDate, format: .dateTime.month().day())
                            }
                            else{
                                Text(reminder.startDate, format: .dateTime.month().day())
                            }
                        }
                    }
                }
                Section(header: Text("Notes:")){
                    Text(reminder.notes)
                }
                Section(header: Text("Priority:")){
                
                    HStack{
                        Text(info.prioritites[reminder.priority])
                        Spacer()
                        switch reminder.priority{
                        case 1: Text("!")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        case 2: Text("!!")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        case 3: Text("!!!")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                            
                        default: Text("")
                        }
                        
                    }
                
                }
                
                
                
            }
            
            
            
            
            
        }
        
    }
}


struct viewReminderView_Previews: PreviewProvider {
    static var previews: some View {
        viewReminderView(reminder: Reminder(name: "Test", startDate: Date(), endDate: Date(), notes: "notes", priority: 3, useTime: true, useEndDate: true))
            .environmentObject(Info())
    }
}
