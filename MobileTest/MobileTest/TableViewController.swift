//
//  TableViewController.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 24/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var contasCorrente: [Conta] = []
        var contasPoupanca: [Conta] = []
        var pessoas: [Pessoa] = []
        
        print("to aqui")
        guard let url = URL(string: "https://raw.githubusercontent.com/PauloRicardo56/MobileTest/master/API.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let dataRecuperada = data else { return }
                //                        do {
                //                            print(dataRecuperada)
                //                            let decoder = try JSONDecoder().decode(ContaCorrente.self, from: dataRecuperada)
                //                            print(decoder)
                //                        } catch let error {
                //                            print(error.localizedDescription)
                do {
                    if let objJason = try JSONSerialization.jsonObject(with: dataRecuperada, options: .mutableContainers) as? [String : Any] {
                        if let contaCorrente = objJason["ContaCorrente"] as? [[String : Any]] {
                            for cc in contaCorrente{
                                if let idContaCorrente = cc["id"] as? Int{
                                    if let saldoContaCorrent = cc["saldo"] as? String{
                                        let conta = Conta(id: idContaCorrente, saldo: saldoContaCorrent)
                                        contasCorrente.append(conta)
                                    }
                                }
                            }
                        }
                        if let contaPopupanca = objJason["ContaPoupanca"] as? [[String : Any]] {
                            for cp in contaPopupanca {
                                if let idContaPopupanca = cp["id"] as? Int {
                                    if let saldoContaPopupanca = cp["saldo"] as? String{
                                        let conta = Conta(id: idContaPopupanca, saldo: saldoContaPopupanca)
                                        contasPoupanca.append(conta)
                                    }
                                }
                            }
                        }
                        if let pessoasJson = objJason["Pessoa"] as? [[String : Any]] {
                            for p in pessoasJson {
                                if let idPessoa = p["id"] as? Int, let nome = p["Nome"] as? String, let contatos = p["Contatos"] as? [Int] {
                                    let pessoa = Pessoa(id: idPessoa, nome: nome, contatos: contatos)
                                    pessoas.append(pessoa)
                                }
                            }
                        }
                    }
                } catch let error {
                    print(error)
                }
                
                //                        }
            } else {
                print("Erro na comunicacao", error.debugDescription)
            }
            
            
            }.resume()
        DispatchQueue.main.async {
            for i in contasCorrente {
                print(i.id)
            }
        
            for i in contasPoupanca {
                print(i.id)
            }
            for i in pessoas {
                print(i.nome)
            }
        }
        
    }
    
    @IBAction func button(_ sender: Any) {
        
    }
}
