//
//  File.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 24/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation

class Pessoa {
    let id: Int
    let nome: String
    let contatos: [Int]
    
    init(id: Int, nome: String, contatos: [Int]) {
        self.id = id
        self.nome = nome
        self.contatos = contatos
    }
}
