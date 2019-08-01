//
//  ContatosTableView.swift
//  MobileTest
//
//  Created by Fábio França on 25/07/19.
//  Copyright © 2019 Paulo Ricardo. All rights reserved.
//

import UIKit

class ContatosTableView: NSObject,UITableViewDelegate, UITableViewDataSource {
    var delegate: ContatosTableViewDelegate!
    var nomesContatos: [String] = []
    var contatoSelecionado: Int = -1
    var viewDestino: ContasViewController!
    var names: [Name] = []
    var primeiraLetrasOrdenadas: [String] = []
    var sections: [[Name]] = [[]]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return primeiraLetrasOrdenadas[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nomesContatos = delegate.recuperarContatos()
        //return nomesContatos.count
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nomesContatos[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewDestino.butaoCheck[0] = 1
        if viewDestino.butaoCheck == [1,1] {
            viewDestino.butaoOutlet.isEnabled = true
        }
        contatoSelecionado = indexPath.row
    }
    
}

extension ContatosTableView: RecuperaDestinoDelegate {
    func recuperaDestino() -> Int {
        return contatoSelecionado
    }
}
