//
//  ViewController.swift
//  MobileTest
//
//  Created by Paulo Ricardo on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var contasCorrente: [Conta] = []
    var contasPoupanca: [Conta] = []
    var pessoas: [Pessoa] = []
    @IBOutlet var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
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
                        self.picker.reloadAllComponents()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pessoas.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pessoas[row].nome
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            
            let viewControllerDest = segue.destination as! ContasViewController
            viewControllerDest.delegate = self
            viewControllerDest.pessoa = pessoas[picker.selectedRow(inComponent: 0)]
        }
    }
}


extension ViewController: ContasViewControllerDelegate {
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
        for conta in contasCorrente {
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
    
    
    func recuperarBanco() -> Banco {
        let banco = Banco()
        banco.contaCorrente = self.contasCorrente
        banco.contaPoupanca = self.contasPoupanca
        banco.pessoa = self.pessoas

        return banco
    }
}

