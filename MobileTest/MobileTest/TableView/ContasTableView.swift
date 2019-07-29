//
//  ContasTableView.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ContasTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: ContasTableViewDelegate!
    var saldoContaCorrente: [String] = []
    var saldoContaPoupanca: [String] = []
    var contaSelecionada: Int  = -1
    var viewDestino: ContasViewController!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewDestino.contaSelecionada = self
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.saldoContaCorrente = delegate.recuperarContaCorrente()
        self.saldoContaPoupanca = delegate.recuperarContaPoupanca()
        let qtd = saldoContaCorrente.count + saldoContaPoupanca.count
        return qtd
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row > saldoContaCorrente.count - 1{
            cell.textLabel?.text = saldoContaPoupanca[indexPath.row-saldoContaCorrente.count]
        }else{
            cell.textLabel?.text = saldoContaCorrente[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewDestino.butaoCheck[1] = 1
        if viewDestino.butaoCheck == [1,1] {
            viewDestino.butaoOutlet.isEnabled = true 
        }
        contaSelecionada = indexPath.row
    }
}

extension ContasTableView: RecuperaOrigemDelegate {
    func recuperaOrigem() -> Int {
        return contaSelecionada
    }
    
}

