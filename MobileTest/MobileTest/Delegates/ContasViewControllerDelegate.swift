//
//  ContasTableViewControllerDelegate.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import Foundation


protocol ContasViewControllerDelegate {
    func recuperarContatos(_ pessoaSelecionada: Pessoa) -> [Pessoa]
    func recuperarContaCorrente(_ pessoaSelecionada: Pessoa) -> [Conta]
    func recuperarContaPoupanca(_ pessoaSelecionada: Pessoa) -> [Conta]
    func possuiContaCorrente(_ pessoaSelecionada: Pessoa) -> Bool
    func possuiContaPoupanca(_ pessoaSelecionada: Pessoa) -> Bool
}
