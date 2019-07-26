//
//  Banco.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 24/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation


class Banco: Codable {
    var contaCorrente: [Conta] = []
    var contaPoupanca: [Conta] = []
    var pessoa: [Pessoa] = []
}
