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
    var saldoContasTotais: [String] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "De: "
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.saldoContaCorrente = delegate.recuperarContaCorrente()
        self.saldoContaPoupanca = delegate.recuperarContaPoupanca()
        for saldo in saldoContaCorrente {
            saldoContasTotais.append(saldo)
        }
        for saldo in saldoContaPoupanca {
            saldoContasTotais.append(saldo)
        }
        let qtd = saldoContaCorrente.count + saldoContaPoupanca.count
        return qtd
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = saldoContasTotais[indexPath.row]
        return cell
    }
}
