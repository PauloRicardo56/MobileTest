//
//  ContasTableViewDelegate.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation

protocol ContasTableViewDelegate {
    func recuperarContaCorrente() -> [String]
    func recuperarContaPoupanca() -> [String]
}
