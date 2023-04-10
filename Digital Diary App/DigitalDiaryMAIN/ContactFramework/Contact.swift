//
//  Contact.swift
//  DigitalDiaryMAIN
//
//  Created by user218786 on 4/14/22.
//

import Foundation
import UIKit

struct Contact: Identifiable
{
    
    var id = UUID()
    var firstName: String
    var lastName: String
    var phoneNum: String
    var email: String
    var address: String
    var birthday: Date
    var notes: String
    var image = UIImage()
    var isFavorite: Bool
    
}
