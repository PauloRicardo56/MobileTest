//
//  Name.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class Name {
    let nameTitle: String
    
    init(nameTitle: String) {
        self.nameTitle = nameTitle
    }
    var titleFirstLatter: String{
        return String(self.nameTitle[self.nameTitle.startIndex]).uppercased()
    }
    
}

