//
//  newContactView.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/15/22.
//

import SwiftUI

struct newContactView: View {
    
    @EnvironmentObject var info: Info
    @Environment(\.dismiss) var dismiss
    
    @State var placeholder: String
    
    @State var firstName: String
    @State var lastName: String
    @State var phoneNum: String
    @State var email: String
    @State var address: String
    @State var notes: String
    @State private var birthdate = Date()
    @State private var image = UIImage()
    @State private var isShowPhotoLibrary = false
    
    
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
                        info.newContSheet.toggle()
                        dismiss()
                    },
                           label:
                            {
                        Text("Cancel").foregroundColor(Color.blue)
                    })
                    
                    Spacer()
                    
                    Button(action:
                            {
                        info.newContSheet.toggle()
                        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNum: phoneNum, email: email, address: address, birthday: birthdate, notes: notes, image: image, isFavorite: false)
                        info.contactList.append(newContact)
                        info.contactList = info.contactList.sorted(by: {
                            $0.lastName < $1.lastName
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
                
                Text("New Contact")
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
                Image(uiImage: self.image)
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
                Text("Add Photo")
                    .foregroundColor(Color.blue)
                    .font(.system(size: 15))
            })
            
            Form {
                Section{
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Section{
                    TextField("Phone Number", text: $phoneNum)
                    TextField("Email", text: $email)
                    TextField("Address", text: $address)
                }
                Section{
                    DatePicker("Birthdate", selection: $birthdate, in: ...Date(), displayedComponents: .date)
                }
                Section(header: Text("Notes")){
                    TextEditor(text: $notes)
                }
                
            }
            
            
            
            
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .interactiveDismissDisabled()
        
    }
       
}

struct newContactView_Previews: PreviewProvider {
    static var previews: some View {
        newContactView(placeholder: "", firstName: "", lastName: "", phoneNum: "", email: "", address: "", notes: "")
    }
}
