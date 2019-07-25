//
//  TableViewController.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 24/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var contasCorrente: [Conta] = []
    var contasPoupanca: [Conta] = []
    var pessoas: [Pessoa] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL(string: "https://raw.githubusercontent.com/PauloRicardo56/MobileTest/master/API.json") else { return }
        
        
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                
                guard let dataRecuperada = data else { return }
                do {
                    print(dataRecuperada)
                    let banco = try JSONDecoder().decode(Banco.self, from: dataRecuperada)
                    self.contasCorrente = banco.contaCorrente
                    self.contasPoupanca = banco.contaPoupanca
                    self.pessoas = banco.pessoa
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pessoas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pessoa = pessoas[indexPath.row]
        cell.textLabel?.text = pessoa.nome

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conta"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let pessoaSelecionada = self.pessoas[indexPath.row]
                let viewControllerDestino = segue.destination as! ContasTableViewController
                viewControllerDestino.delegate = self
                viewControllerDestino.pessoa = pessoaSelecionada
            }
        }
    }
}

extension TableViewController: ContasTableViewControllerDelegate{
    func recuperarContatos(_ pessoaSelecionada: Pessoa) -> [Pessoa] {
        var contatosRecuperados: [Pessoa] = []
        
        for pessoa in pessoas{
            for idContatos in pessoaSelecionada.contatos{
                if pessoa.id == idContatos {
                    contatosRecuperados.append(pessoa)
                }
            }
        }
        
        return contatosRecuperados
    }
    
    func recuperarContaCorrente(_ pessoaSelecionada: Pessoa) -> [Conta] {
        var contaRecuperada: Array<Conta> = []
        for conta in contasCorrente{
            if conta.id == pessoaSelecionada.id {
                contaRecuperada.append(conta)
            }
        }
        
        return contaRecuperada
    }
    
    func recuperarContaPoupanca(_ pessoaSelecionada: Pessoa) -> [Conta] {
        var contaRecuperada: Array<Conta> = []
        for conta in contasPoupanca{
            if conta.id == pessoaSelecionada.id {
                contaRecuperada.append(conta)
            }
        }
        
        return contaRecuperada
    }
    
    func possuiContaCorrente(_ pessoaSelecionada: Pessoa) -> Bool {
        for conta in contasCorrente{
            if conta.id == pessoaSelecionada.id {
                return true
            }
        }
        return false
    }
    
    func possuiContaPoupanca(_ pessoaSelecionada: Pessoa) -> Bool {
        for conta in contasPoupanca{
            if conta.id == pessoaSelecionada.id {
                return true
            }
        }
        return false
    }
}
