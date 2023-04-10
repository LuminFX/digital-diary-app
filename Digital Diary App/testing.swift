//
//  testing.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/15/22.
//

import SwiftUI
import UserNotifications

struct testing: View {
    
    
    var body: some View {
        
        VStack{
            
            Button("Request Permission"){
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success{
                        print("all set")
                    } else if let error = error{
                        print(error.localizedDescription)
                    }
                }
                
            }
            Button("Schedule Notification"){
                
                let content = UNMutableNotificationContent()
                content.title = "feed the dogs"
                content.subtitle = "they look hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }
            
        }
        
        
    }
}


struct testing_Previews: PreviewProvider {
    static var previews: some View {
        testing()
    }
}
