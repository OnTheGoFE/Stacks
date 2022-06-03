//
//  ViewController.swift
//  ScrollStack
//
//  Created by Jonathan Viloria M on 29/05/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var rootStacks: [GrupoStacks] = [GrupoStacks]()
    let jsonData = """
{
  "grupos": [
    {
      "id": 1,
      "name": "Grupo A",
      "categorias": [
        {
          "id": 11,
          "name": "Categoría AA",
          "expedientes": [
            {
              "id": 111,
              "name": "Expediente AAA"
            },
            {
              "id": 111,
              "name": "Expediente AAA"
            }
          ]
        }
      ]
    },
    {
      "id": 2,
      "name": "Grupo B",
      "categorias": [
        {
          "id": 22,
          "name": "Categoría BB",
          "expedientes": [
            {
              "id": 222,
              "name": "Expediente BBB"
            },
            {
              "id": 222,
              "name": "Expediente BBB"
            }
          ]
        }
      ]
    }
  ]
}
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let welcome = try? JSONDecoder().decode(StackObject.self, from: jsonData.data(using: .utf8) ?? Data())
        var topEdge: ConstraintItem = self.view.safeAreaLayoutGuide.snp.top
        
        let root = UIStackView()
        root.axis = .vertical
        root.distribution = .equalSpacing
        root.alignment = .leading
        root.spacing = 0
        root.backgroundColor = .yellow
        
        self.view.addSubview(root)
        
        // AddingStackView
        welcome?.grupos.enumerated().forEach({ (i, grupo) in
            
            // Setting labels
            let titleStack = UILabel()
            titleStack.text = grupo.name
            titleStack.textColor = UIColor.black
            titleStack.numberOfLines = 0
            titleStack.textAlignment = .left
            
            let buttonStack = UIButton()
            buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            buttonStack.setTitle("Grupo:\(i)", for: .reserved)
            buttonStack.tag = 1
            buttonStack.frame.size.width = 48
            buttonStack.frame.size.height = 48
            buttonStack.addTarget(self, action: #selector(self.toogleAction), for: .touchUpInside)

            let stack = UIStackView()
            stack.addArrangedSubview(titleStack)
            stack.addArrangedSubview(buttonStack)
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .leading
            stack.spacing = 0
            stack.backgroundColor = .yellow
            
            let grupoStack = GrupoStacks()
            grupoStack.stack = stack
            grupoStack.isExpanded = false
            grupoStack.categorias = [CategoriasStacks]()
            
            root.addArrangedSubview(stack)
            
            topEdge = stack.snp.bottom
            
            grupo.categorias.enumerated().forEach { (j, categoria) in
                
                // Setting labels
                let titleStack = UILabel()
                titleStack.text = categoria.name
                titleStack.textColor = UIColor.black
                titleStack.numberOfLines = 0
                titleStack.textAlignment = .left
                
                let buttonStack = UIButton()
                buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
                buttonStack.setTitle("Categoria:\(j)", for: .reserved)
                buttonStack.tag = 1
                buttonStack.frame.size.width = 48
                buttonStack.frame.size.height = 48
                buttonStack.addTarget(self, action: #selector(self.toogleAction), for: .touchUpInside)

                let stack = UIStackView()
                stack.addArrangedSubview(titleStack)
                stack.addArrangedSubview(buttonStack)
                stack.axis = .horizontal
                stack.distribution = .equalSpacing
                stack.alignment = .leading
                stack.spacing = 0
                stack.backgroundColor = .red
                stack.isHidden = true
                
                let categoriaStack = CategoriasStacks()
                categoriaStack.stack = stack
                categoriaStack.grupo = i
                categoriaStack.isExpanded = false
                categoriaStack.expedientes = [ExpedientesStacks]()
                root.addArrangedSubview(stack)
                
                topEdge = stack.snp.bottom
                
                categoria.expedientes.enumerated().forEach { (k, expediente) in
                    
                    // Setting labels
                    let titleStack = UILabel()
                    titleStack.text = expediente.name
                    titleStack.textColor = UIColor.black
                    titleStack.numberOfLines = 0
                    titleStack.textAlignment = .left
                    
                    let buttonStack = UIButton()
                    buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
                    buttonStack.setTitle("Expediente:\(k)", for: .reserved)
                    buttonStack.tag = 1
                    buttonStack.frame.size.width = 48
                    buttonStack.frame.size.height = 48
                    buttonStack.addTarget(self, action: #selector(self.toogleAction), for: .touchUpInside)

                    let stack = UIStackView()
                    stack.addArrangedSubview(titleStack)
                    stack.addArrangedSubview(buttonStack)
                    stack.axis = .horizontal
                    stack.distribution = .equalSpacing
                    stack.alignment = .leading
                    stack.spacing = 0
                    stack.backgroundColor = .green
                    stack.isHidden = true
                    
                    let expedienteStack = ExpedientesStacks()
                    expedienteStack.stack = stack
                    expedienteStack.categoria = j
                    expedienteStack.isExpanded = false
                    categoriaStack.expedientes.append(expedienteStack)
                    root.addArrangedSubview(stack)
                    
                    topEdge = stack.snp.bottom
                    
                }
                
                grupoStack.categorias.append(categoriaStack)

                
            }
            
            rootStacks.append(grupoStack)

            
        })
        
        root.snp.makeConstraints { (make) in
            make.centerX.left.right.equalTo(self.view)
            make.top.equalTo(40)
            make.bottom.equalTo(topEdge)
        }
        
    }

    @objc func toogleAction(sender: UIButton){
        guard let title = sender.title(for: .reserved) else{ return }
        let split = title.split(separator: ":")
        let index = Int(split[1]) ?? 0
        if title.contains("Expediente"){
            
        }else if title.contains("Categoria"){
            
        }else if title.contains("Grupo"){
            shGrupo(sender: rootStacks[index])
        }
        if(sender.tag == 0){
            sender.setImage(UIImage(named: "expand_less_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            sender.tag = 1
        }else{
            sender.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            sender.tag = 0
        }
        
    }
    
    func shGrupo(sender: GrupoStacks){
        sender.isExpanded = !sender.isExpanded
        if sender.isExpanded{
            sender.categorias.forEach { categoria in
                categoria.stack.isHidden = true
                categoria.expedientes.forEach { expediente in
                    expediente.stack.isHidden = true
                }
            }
        }else{
            sender.categorias.forEach { categoria in
                categoria.stack.isHidden = false
                categoria.expedientes.forEach { expediente in
                    expediente.stack.isHidden = false
                }
            }
        }
        
    }
    
    func shCategoria(sender: Int){
        
    }

}

class GrupoStacks: NSObject{
    var isExpanded: Bool!
    var stack: UIStackView!
    var categorias: [CategoriasStacks]!
}
class CategoriasStacks: NSObject{
    var isExpanded: Bool!
    var stack: UIStackView!
    var grupo: Int!
    var expedientes: [ExpedientesStacks]!
}
class ExpedientesStacks: NSObject{
    var categoria: Int!
    var isExpanded: Bool!
    var stack: UIStackView!
}

// MARK: - Welcome
struct StackObject: Codable {
    let grupos: [Grupo]
}

// MARK: - Grupo
struct Grupo: Codable {
    let id: Int
    let name: String
    let categorias: [Categoria]
}

// MARK: - Categoria
struct Categoria: Codable {
    let id: Int
    let name: String
    let expedientes: [Expediente]
}

// MARK: - Expediente
struct Expediente: Codable {
    let id: Int
    let name: String
}
