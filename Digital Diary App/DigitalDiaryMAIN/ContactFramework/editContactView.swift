//
//  editContactView.swift
//  DigitalDiaryMAIN
//
//  Created by user220221 on 4/16/22.
//

import SwiftUI

struct editContactView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowPhotoLibrary = false
    
    @State var contact: Contact
    
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
                        info.editContSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Cancel").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                    
                    Button(action:
                            {
                        if let index = info.contactList.firstIndex(where: {$0.id == contact.id}){
                            
                            info.contactList[index] = contact
                            
                        }
                        info.contactList = info.contactList.sorted(by: {
                            $0.lastName < $1.lastName
                        })
                        info.editContSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Done").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                        .frame(width:15)
                }
                
                Text("Edit Contact")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
            }
            
            
            
            Spacer()
                .frame(height:10)
            
            ZStack {
                Image("md-contact")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(50)
                Image(uiImage: contact.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(120)
            }
            
            Button(action:
                    {
                self.isShowPhotoLibrary = true
            },
                   label:
                    {
                Text("Edit Photo")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 15))
            })
            
            Form {
                Section{
                    TextField("First Name", text: $contact.firstName)
                    TextField("Last Name", text: $contact.lastName)
                }
                Section{
                    TextField("Phone Number", text: $contact.phoneNum)
                    TextField("Email", text: $contact.email)
                    TextField("Address", text: $contact.address)
                }
                Section{
                    DatePicker("Birthdate", selection: $contact.birthday, in: ...Date(), displayedComponents: .date)
                }
                Section(header: Text("Notes")){
                    TextEditor(text: $contact.notes)
                }
                
            }
            
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$contact.image)
        }
        .interactiveDismissDisabled()
        
    }
}


struct editContactView_Previews: PreviewProvider {
    static var previews: some View {
        editContactView(contact: Contact(firstName: "Tyler", lastName: "Schmitz", phoneNum: "+1(818)335-5275", email: "tmschmitz@cox.net", address: "28514 Coveridge Drive", birthday: Date(), notes: "Best compsci advanced student", isFavorite: false))
    }
}
