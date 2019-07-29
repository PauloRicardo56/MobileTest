//
//  ConfirmacaoTableViewController.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ConfirmacaoTableViewController: UITableViewController {
    

    @IBOutlet weak var contaOrigemTextField: UILabel!
    @IBOutlet weak var contaDestinoTextField: UILabel!
    @IBOutlet weak var valorTextField: UILabel!
    var contaString: String = ""
    var valorSoma: Double = 0.0
    var banco: Banco!
    
    var contaOrigem: Conta!
    var contatoDestino: Pessoa!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contaOrigemTextField.text = contaString
        contaDestinoTextField.text = contatoDestino.nome
        
        print("Banco\(banco.contaPoupanca[0].saldo)")
        
        valorTextField.text = "\(valorSoma)"
    }

    
    @IBAction func addUm(_ sender: Any) {
        valorSoma += 1
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addCinco(_ sender: Any) {
        valorSoma += 5
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func addDez(_ sender: Any) {
        valorSoma += 10
        valorTextField.text = "\(valorSoma)"
    }
    
    
    @IBAction func confirmar(_ sender: Any) {
        
        let fileName = "Banco.json"
        var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        dir[0].appendPathComponent(fileName)
        
        // Conta Origem
        if (contaOrigemTextField?.text!.contains("Poupanca"))! {
            
            for i in banco.contaPoupanca {
                if contaOrigem! === i {
                    i.saldo = String(Double(i.saldo)! - self.valorSoma)
                }
            }
        } else {
            
            for i in banco.contaCorrente {
                if contaOrigem! === i {
                    i.saldo = String(Double(i.saldo)! - self.valorSoma)
                }
            }
        }
        
        // Conta Destino (conta corrente vem primeiro)
        var flag: Int = 0
        for i in banco.contaCorrente {
            
            if contatoDestino.id == i.id {
                i.saldo = String(Double(i.saldo)! + self.valorSoma)
                flag = 1
            }
        }
        if flag != 1 {
            
            for i in banco.contaPoupanca {
                
                if contatoDestino.id == i.id {
                    i.saldo = String(Double(i.saldo)! + self.valorSoma)
                    flag = 1
                }
            }
        }
        
        let jsonData = try? JSONEncoder().encode(banco)
        try? jsonData?.write(to: dir[0])
        
        print(dir[0].absoluteString)
    }
}
