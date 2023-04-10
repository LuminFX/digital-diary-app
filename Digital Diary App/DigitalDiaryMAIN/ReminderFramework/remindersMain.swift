//
//  remindersMain.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/14/22.
//

import SwiftUI

struct remindersMain: View {
    
    @EnvironmentObject var info: Info
    @State private var showingSheet = false
    @State var now = Date.now
    @State var tomorrow = Date.now.addingTimeInterval(86400)
    @State var forever = Date.distantFuture
    
    
    var body: some View {
        
        VStack{
            HStack()
            {
                Spacer()
                    .frame(width: 20)
                Text("Reminders")
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
                
                Button(action:
                        {
                    showingSheet.toggle()
                    info.newReminderSheet.toggle()
                },
                       label:
                        {
                    Text(Image(systemName: "plus")).foregroundColor(Color.black)
                })
                Spacer()
                    .frame(width: 20)
            }
            
            List{
                Section(header: Text("Next 24 Hours:")
                    .fontWeight(.semibold)
                    .font(.system(size: 15)))
                {
                    
                    ForEach(info.reminderList)
                    {Reminder in
                        
                        if((...tomorrow).contains(Reminder.startDate)){
                            
                            ReminderView(reminder: Reminder)
                            .swipeActions(edge: .trailing){
                                
                                Button(action:
                                        {
                                    info.reminderList.removeAll(where: {$0.id == Reminder.id})
                                },
                                       
                                       label:
                                        {
                                    Label("Delete", systemImage: "trash.circle.fill")
                                })
                                .tint(.red)
                                
                                Button(action:
                                        {
                                    info.reminderStore = Reminder
                                    info.selectedPriority = info.prioritites[Reminder.priority]
                                    showingSheet.toggle()
                                    info.editReminderSheet.toggle()
                                },
                                       label:
                                        {
                                    Label("Edit", systemImage: "pencil")
                                })
                                .tint(.blue)
                                
                            }
                            .onTapGesture {
                                info.reminderStore = Reminder
                                showingSheet.toggle()
                            }

                        }
                                                    
                    }
                    
                }
                Section(header: Text("Coming up:")
                    .fontWeight(.semibold)
                    .font(.system(size: 15)))
                {
                    
                    ForEach(info.reminderList)
                    {Reminder in
                        
                        if((tomorrow...forever).contains(Reminder.startDate)){
                            
                            ReminderView(reminder: Reminder)
                            .swipeActions(edge: .trailing){
                                
                                Button(action:
                                        {
                                    info.reminderList.removeAll(where: {$0.id == Reminder.id})
                                },
                                       
                                       label:
                                        {
                                    Label("Delete", systemImage: "trash.circle.fill")
                                })
                                .tint(.red)
                                
                                Button(action:
                                        {
                                    info.reminderStore = Reminder
                                    info.selectedPriority = info.prioritites[Reminder.priority]
                                    showingSheet.toggle()
                                    info.editReminderSheet.toggle()
                                },
                                       label:
                                        {
                                    Label("Edit", systemImage: "pencil")
                                })
                                .tint(.blue)
                                
                            }
                            .onTapGesture {
                                info.reminderStore = Reminder
                                showingSheet.toggle()
                            }

                        }
                                                    
                    }
                    
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $showingSheet){
            
            if info.newReminderSheet {
                newReminderView(name: "", notes: "")
            }
            else if info.editReminderSheet{
                editReminderView(reminder: info.reminderStore)
            }
            else{
                viewReminderView(reminder: info.reminderStore)
            }
            
        }
        
    }
}

struct ReminderView: View {
    
    var reminder: Reminder
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text(reminder.name)
                    .font(.system(size: 24, weight: .medium, design: .default))
                HStack {
                    
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

