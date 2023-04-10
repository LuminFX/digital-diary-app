//
//  contactsMain.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/14/22.
//

import SwiftUI

struct contactsMain: View {
    
    @EnvironmentObject var info: Info
    @State private var showingSheet = false
    
    
    var body: some View {
        
        VStack
        {
            HStack()
            {
                Spacer()
                    .frame(width: 20)
                Text("Contacts")
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
                
                Button(action:
                        {
                    showingSheet.toggle()
                    info.newContSheet.toggle()
                },
                       label:
                        {
                    Text(Image(systemName: "plus")).foregroundColor(Color.black)
                })
                Spacer()
                    .frame(width: 20)
            }
            
            List{
                
                Section(header: Text("Favorites:")
                    .fontWeight(.semibold)
                    .font(.system(size: 15)))
                {
                    
                    ForEach(info.contactList)
                    {Contact in
                        
                        if Contact.isFavorite{
                            
                            ContactView(contact: Contact)
                                .swipeActions(edge: .leading){
                                    Button(action:
                                            {
                                        info.contactList[info.contactList.firstIndex(where: {$0.id == Contact.id}) ?? 0].isFavorite.toggle()
                                    },
                                           
                                           label:
                                            {
                                        Label("Favorite", systemImage: "star.fill")
                                    })
                                    .tint(.yellow)                        }
                                .swipeActions(edge: .trailing){
                                    
                                    Button(action:
                                            {
                                        info.contactList.removeAll(where: {$0.id == Contact.id})
                                    },
                                           
                                           label:
                                            {
                                        Label("Delete", systemImage: "trash.circle.fill")
                                    })
                                    .tint(.red)
                                    
                                    Button(action:
                                            {
                                        info.contStore = Contact
                                        showingSheet.toggle()
                                        info.editContSheet.toggle()
                                    },
                                           label:
                                            {
                                        Label("Edit", systemImage: "pencil")
                                    })
                                    .tint(.blue)
                                    
                                }
                                .onTapGesture {
                                    info.contStore = Contact
                                    showingSheet.toggle()
                                }
                            
                            
                        }
                        
                    }
                    
                }
                
            
                
                Section(header: Text("Contacts:")
                    .fontWeight(.semibold)
                    .font(.system(size: 15)))
                {
                    
                    ForEach(info.contactList)
                    {Contact in
                        
                        if !Contact.isFavorite{
                            
                            ContactView(contact: Contact)
                                .swipeActions(edge: .leading){
                                    Button(action:
                                            {
                                        info.contactList[info.contactList.firstIndex(where: {$0.id == Contact.id}) ?? 0].isFavorite.toggle()
                                    },
                                           
                                           label:
                                            {
                                        Label("Favorite", systemImage: "star.fill")
                                    })
                                    .tint(.yellow)                        }
                                .swipeActions(edge: .trailing){
                                    
                                    Button(action:
                                            {
                                        info.contactList.removeAll(where: {$0.id == Contact.id})
                                    },
                                           
                                           label:
                                            {
                                        Label("Delete", systemImage: "trash.circle.fill")
                                    })
                                    .tint(.red)
                                    
                                    Button(action:
                                            {
                                        info.contStore = Contact
                                        showingSheet.toggle()
                                        info.editContSheet.toggle()
                                    },
                                           label:
                                            {
                                        Label("Edit", systemImage: "pencil")
                                    })
                                    .tint(.blue)
                                    
                                }
                                .onTapGesture {
                                    info.contStore = Contact
                                    showingSheet.toggle()
                                }
                            
                            
                        }
                        
                    }
                    
                }

            }
            
            
            Spacer()
            
        }
        .sheet(isPresented: $showingSheet){
            
            if info.newContSheet {
                newContactView(placeholder: "", firstName: "", lastName: "", phoneNum: "", email: "", address: "", notes: "")
            }
            else if info.editContSheet{
                editContactView(contact: info.contStore)
            }
            else{
                viewContactView(contact: info.contStore)
            }
            
        }
        
    }
    
    
    struct ContactView: View {
        
        var contact: Contact
        
        var body: some View{
            
            HStack {
                
                ZStack {
                    Image("md-contact")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(50)
                    Image(uiImage: contact.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(100)
                }
                
                VStack(alignment: .leading) {
                    Text(contact.firstName + " " + contact.lastName)
                        .font(.system(size: 21, weight: .medium, design: .default))
                    Text(contact.phoneNum)
                }
                Spacer()
            }
        }
    }
    
}
