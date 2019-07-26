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
    
    var contaCorrenteSaldos: Array<String> = []
    var contaPoupancaSaldos: Array<String> = []
    var nomesContatos: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        sections.append("De:")
        sections.append("De:")
        sections.append("Para: ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if delegate.possuiContaCorrente(pessoa){
            let contasRecuperadas = delegate.recuperarContaCorrente(pessoa)
            contasCorrente = contasRecuperadas
        }
        if delegate.possuiContaPoupanca(pessoa){
            let contasRecuperadas = delegate.recuperarContaPoupanca(pessoa)
            contasPoupanca = contasRecuperadas
        }
        contatos = delegate.recuperarContatos(pessoa)
        
        for contato in contatos {
            nomesContatos.append(contato.nome)
        }
        
        for conta in contasPoupanca {
            contaPoupancaSaldos.append("Conta Poupaca: R$\(conta.saldo)")
        }
        
        for conta in contasCorrente {
            contaCorrenteSaldos.append("Conta Corrente: R$\(conta.saldo)")
        }
        itens.append(contaCorrenteSaldos)
        itens.append(contaPoupancaSaldos)
        itens.append(nomesContatos)
        
        print(itens)
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let contato = pessoa.contatos[indexPath.row]
//        cell.textLabel?.text = String(contato)
        cell.textLabel?.text = itens[indexPath.section][indexPath.row]
    
        return cell
    }

    
}


