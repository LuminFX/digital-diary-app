//
//  viewContactView.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/17/22.
//

import SwiftUI

struct viewContactView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State var contact: Contact
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height:15)
            
            ZStack {
                Image("md-contact")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(50)
                Image(uiImage: contact.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 123, height: 123)
                    .clipped()
                    .cornerRadius(120)
                
            }
            
            
            HStack {
                Text(contact.firstName + " " + contact.lastName)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
            }
            
            
            Form {
                Section(header: Text("Phone Number")){
                    Text(contact.phoneNum)
                }
                Section(header: Text("Email")){
                    Text(contact.email)
                }
                Section(header: Text("Address")){
                    Text(contact.address)
                }
                Section(header: Text("Birthdate")){
                    Text(contact.birthday, style: .date)
                }
                Section(header: Text("Notes")){
                    Text(contact.notes)
                }
                
            }
            
            
            
            
            
        }
        
    }
}


struct viewContactView_Previews: PreviewProvider {
    static var previews: some View {
        viewContactView(contact: Contact(firstName: "Tyler", lastName: "Schmitz", phoneNum: "+1(818)335-5275", email: "tmschmitz@cox.net", address: "28514 Coveridge Drive", birthday: Date(), notes: "Best compsci advanced student", isFavorite: true))
    }
}
