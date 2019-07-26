//
//  ContasViewController.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ContasViewController: UIViewController {
    
    var pessoa: Pessoa!
    var delegate: ContasTableViewControllerDelegate!
    var contasCorrente: Array<Conta> = []
    var contasPoupanca: Array<Conta> = []
    var contatos: Array<Pessoa> = []
    var names: [Name] = []
    var sortedFirstLetter: [String] = []
    var sections: [[Name]] = [[]]
    
    var contaCorrenteSaldos: Array<String> = []
    var contaPoupancaSaldos: Array<String> = []
    var nomesContatos: Array<String> = []

    @IBOutlet weak var tableViewContas: UITableView!
    @IBOutlet weak var tableViewContatos: UITableView!
    
    let tableViewContasDelegate = ContasTableView()
    let tableViewContatosDelegate = ContatosTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContasDelegate.delegate = self
        tableViewContatosDelegate.delegate = self
        
        tableViewContas.delegate = tableViewContasDelegate
        tableViewContas.dataSource = tableViewContasDelegate
        tableViewContatos.delegate = tableViewContatosDelegate
        tableViewContatos.dataSource = tableViewContatosDelegate
        
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
        
        for nome in nomesContatos {
            names.append(Name.init(nameTitle: nome))
        }
        
        let firstLetters = names.map{$0.titleFirstLatter}
        var uniqueFirstLetters = Array(Set(firstLetters))
        
        tableViewContas.reloadData()
        tableViewContatos.reloadData()
    }
}

extension ContasViewController: ContasTableViewDelegate {
    func recuperarContaCorrente() -> [String] {
        return contaCorrenteSaldos
    }
    
    func recuperarContaPoupanca() -> [String] {
        return contaPoupancaSaldos
    }
}

extension ContasViewController: ContatosTableViewDelegate {
    func recuperarContatos() -> [String] {
        return nomesContatos
    }
}
