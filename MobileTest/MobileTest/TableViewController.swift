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
//                do {
//                    if let objJason = try JSONSerialization.jsonObject(with: dataRecuperada, options: .mutableContainers) as? [String : Any] {
//                        if let contaCorrente = objJason["ContaCorrente"] as? [[String : Any]] {
//                            for cc in contaCorrente{
//                                if let idContaCorrente = cc["id"] as? Int{
//                                    if let saldoContaCorrent = cc["saldo"] as? String{
//                                        let conta = Conta(id: idContaCorrente, saldo: saldoContaCorrent)
//                                        self.contasCorrente.append(conta)
//                                    }
//                                }
//                            }
//                        }
//                        if let contaPopupanca = objJason["ContaPoupanca"] as? [[String : Any]] {
//                            for cp in contaPopupanca {
//                                if let idContaPopupanca = cp["id"] as? Int {
//                                    if let saldoContaPopupanca = cp["saldo"] as? String{
//                                        let conta = Conta(id: idContaPopupanca, saldo: saldoContaPopupanca)
//                                        self.contasPoupanca.append(conta)
//                                    }
//                                }
//                            }
//                        }
//                        if let pessoasJson = objJason["Pessoa"] as? [[String : Any]] {
//                            for p in pessoasJson {
//                                if let idPessoa = p["id"] as? Int, let nome = p["Nome"] as? String, let contatos = p["Contatos"] as? [Int] {
//                                    let pessoa = Pessoa(id: idPessoa, nome: nome, contatos: contatos)
//                                    self.pessoas.append(pessoa)
//                                }
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                } catch let error {
//                    print(error)
//                }
//            } else {
//                print("Erro na comunicacao", error.debugDescription)
//            }
//            }.resume()
//    }
    
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
                viewControllerDestino.pessoa = pessoaSelecionada
            }
        }
    }
}
