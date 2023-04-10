//
//  ContentView.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/14/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var selection: Tab = .contacts
    @StateObject var info = Info()
    
    enum Tab{
        case contacts
        case reminders
    }
    
    var body: some View {
        
        TabView(selection: $selection){
            
            contactsMain()
                .tabItem{
                    
                    Label("Contacts", systemImage: "person.crop.circle.fill")
                    
                }
                .tag(Tab.contacts)
            
            remindersMain()
                .tabItem{
                    
                    Label("Reminders", systemImage: "alarm.fill")
                    
                }
                .tag(Tab.reminders)
            
        }.environmentObject(info)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

