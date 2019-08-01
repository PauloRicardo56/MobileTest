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
    var delegate: ContasViewControllerDelegate!
    var contasCorrente: Array<Conta> = []
    var contasPoupanca: Array<Conta> = []
    var contatos: [Pessoa] = []
    var names: [Name] = []
    var contaSelecionada: RecuperaOrigemDelegate!
    var contatoSelecionada: RecuperaDestinoDelegate!
    var contaOrigem: Conta!
    var contatoDestino: Pessoa!
    var butaoCheck: [Int] = [0,0]
    var stringConta:String = ""
    
    var contaCorrenteSaldos: Array<String> = []
    var contaPoupancaSaldos: Array<String> = []

    @IBOutlet weak var tableViewContas: UITableView!
    @IBOutlet weak var tableViewContatos: UITableView!
    @IBOutlet weak var butaoOutlet: UIButton!
    
    let tableViewContasDelegate = ContasTableView()
    let tableViewContatosDelegate = ContatosTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContasDelegate.viewDestino = self
        tableViewContatosDelegate.viewDestino = self
        tableViewContasDelegate.delegate = self
        
        tableViewContas.delegate = tableViewContasDelegate
        tableViewContas.dataSource = tableViewContasDelegate
        tableViewContatos.delegate = tableViewContatosDelegate
        tableViewContatos.dataSource = tableViewContatosDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        butaoOutlet.isEnabled = false
        butaoCheck = [0,0]
        
        if delegate.possuiContaCorrente(pessoa){
            let contasRecuperadas = delegate.recuperarContaCorrente(pessoa)
            contasCorrente = contasRecuperadas
        }
        if delegate.possuiContaPoupanca(pessoa){
            let contasRecuperadas = delegate.recuperarContaPoupanca(pessoa)
            contasPoupanca = contasRecuperadas
        }
        contatos = delegate.recuperarContatos(pessoa)
        print(contatos)
        
        //ordenar o array de contatos pelo nome
        contatos.sort(by: ordenarPorNome)
        
        tableViewContatosDelegate.contatos = contatos
        
        contaPoupancaSaldos = []
        for conta in contasPoupanca {
            contaPoupancaSaldos.append("Conta Poupaca: R$\(conta.saldo)")
        }
        
        contaCorrenteSaldos = []
        for conta in contasCorrente {
            contaCorrenteSaldos.append("Conta Corrente: R$\(conta.saldo)")
        }
        
        tableViewContas.reloadData()
        tableViewContatos.reloadData()
    }
    
    @IBAction func confirmarInformacoes(_ sender: Any) {
        let linhaContaSelecionada = self.contaSelecionada.recuperaOrigem()
        let linhaContatoSelecionada = self.contatoSelecionada.recuperaDestino()
        
        
        if linhaContatoSelecionada != -1 && linhaContaSelecionada != -1 {
            if linhaContaSelecionada > contasCorrente.count - 1 {
                print(linhaContaSelecionada)
                print(contasCorrente.count - 1)
                contaOrigem = contasPoupanca[linhaContaSelecionada-contasCorrente.count]
                stringConta = "Conta Poupaca: R$\(contasPoupanca[linhaContaSelecionada-contasCorrente.count].saldo)"
            }else {
                contaOrigem = contasCorrente[linhaContaSelecionada]
                stringConta = "Conta Corrente: R$\(contasCorrente[linhaContaSelecionada].saldo)"
            }
            
            
            contatoDestino = contatos[linhaContatoSelecionada]
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmacao" {
            let viewControllerdestino = segue.destination as! ConfirmacaoTableViewController
            viewControllerdestino.contatoDestino = contatoDestino
            viewControllerdestino.contaOrigem = contaOrigem
            viewControllerdestino.contaString = stringConta
            viewControllerdestino.bancoGeral = delegate.recuperarBanco()
        }
    }
    
    func ordenarPorNome(this:Pessoa, that:Pessoa) -> Bool {
        return this.nome < that.nome
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

