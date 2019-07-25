//
//  ContasTableViewController.swift
//  MobileTest
//
//  Created by Fábio França on 24/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit


class ContasTableViewController: UITableViewController {

    var pessoa: Pessoa!
    var delegate: ContasTableViewControllerDelegate!
    var contasCorrente: Array<Conta> = []
    var contasPoupanca: Array<Conta> = []
    var contatos: Array<Pessoa> = []
    var itens: [Array<String>] = []
    
    var sections:Array<String> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sections.removeAll()
        if delegate.possuiContaCorrente(pessoa){
            sections.append("Conta Corrente")
            let contasRecuperadas = delegate.recuperarContaCorrente(pessoa)
            contasCorrente = contasRecuperadas
        }
        if delegate.possuiContaPoupanca(pessoa){
            sections.append("Conta Poupança")
            let contasRecuperadas = delegate.recuperarContaPoupanca(pessoa)
            contasPoupanca = contasRecuperadas

        }
        sections.append("Contatos")
        contatos = delegate.recuperarContatos(pessoa)
        
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pessoa.contatos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contato = pessoa.contatos[indexPath.row]
        cell.textLabel?.text = String(contato)
    
        return cell
    }
}


