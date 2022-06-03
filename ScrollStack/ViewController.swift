//
//  ViewController.swift
//  ScrollStack
//
//  Created by Jonathan Viloria M on 29/05/22.
//

import UIKit
import SnapKit

class StackButton: UIButton {

    var idGpo: Int
    var idCat: Int
    var idExp: Int

    required init(g: Int = -1, c: Int = -1, e: Int = -1) {
        // set myValue before super.init is called
        self.idGpo = g
        self.idCat = c
        self.idExp = e

        super.init(frame: .zero)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

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
            
            let buttonStack = StackButton()
            buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            buttonStack.setTitle("Grupo:\(i)", for: .reserved)
            buttonStack.tag = 1
            buttonStack.idGpo = i
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
                
                let buttonStack = StackButton()
                buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
                buttonStack.setTitle("Categoria:\(j)", for: .reserved)
                buttonStack.tag = 0
                buttonStack.idGpo = i
                buttonStack.idCat = j
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
                    
                    let buttonStack = StackButton()
                    buttonStack.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
                    buttonStack.setTitle("Expediente:\(k)", for: .reserved)
                    buttonStack.tag = 0
                    buttonStack.idGpo = i
                    buttonStack.idCat = j
                    buttonStack.idExp = k
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
                    
                    root.addArrangedSubview(stack)
                    
                    topEdge = stack.snp.bottom
                    
                    (0...1).forEach { file in
                        
                        // Setting labels
                        let titleStack = UILabel()
                        titleStack.text = "Hello World"
                        titleStack.textColor = UIColor.black
                        titleStack.numberOfLines = 0
                        titleStack.textAlignment = .left
                        
                        let stack = UIStackView()
                        stack.addArrangedSubview(titleStack)
                        stack.axis = .horizontal
                        stack.distribution = .equalSpacing
                        stack.alignment = .leading
                        stack.spacing = 0
                        stack.backgroundColor = .orange
                        stack.isHidden = true
                        
                        let itemStacks = ItemStacks()
                        itemStacks.stack = stack
                        
                        expedienteStack.item = itemStacks
                        
                        root.addArrangedSubview(stack)
                        
                        topEdge = stack.snp.bottom
                        
                    }
                    
                    
                    categoriaStack.expedientes.append(expedienteStack)
                    
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
        
        if(sender.tag == 0){
            sender.setImage(UIImage(named: "expand_less_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            sender.tag = 1
        }else{
            sender.setImage(UIImage(named: "expand_more_FILL0_wght400_GRAD0_opsz48"), for: .normal)
            sender.tag = 0
        }
        if title.contains("Expediente"){
            shExpediente(sender: sender as! StackButton)
        }else if title.contains("Categoria"){
            shCategoria(sender: sender as! StackButton)
        }else if title.contains("Grupo"){
            shGrupo(sender: sender as! StackButton)
        }
    }
    
    func shGrupo(sender: StackButton){
        if sender.tag == 0{
            rootStacks[sender.idGpo].categorias.forEach { categoria in
                categoria.stack.isHidden = true
                categoria.expedientes.forEach { expediente in
                    expediente.stack.isHidden = true
                }
            }
        }else{
            rootStacks[sender.idGpo].categorias.forEach { categoria in
                categoria.stack.isHidden = false
                categoria.expedientes.forEach { expediente in
                    expediente.stack.isHidden = false
                }
            }
        }
    }
    
    func shCategoria(sender: StackButton){
        if sender.tag == 0{
            rootStacks[sender.idGpo].categorias[sender.idCat].expedientes.forEach { expediente in
                expediente.stack.isHidden = true
            }
        }else{
            rootStacks[sender.idGpo].categorias[sender.idCat].expedientes.forEach { expediente in
                expediente.stack.isHidden = false
            }
        }
    }
    
    func shExpediente(sender: StackButton){
        if sender.tag == 0{
            rootStacks[sender.idGpo].categorias[sender.idCat].expedientes[sender.idExp].item.stack.isHidden = true
        }else{
            rootStacks[sender.idGpo].categorias[sender.idCat].expedientes[sender.idExp].item.stack.isHidden = false
        }
    }

}

class GrupoStacks: NSObject{
    var stack: UIStackView!
    var categorias: [CategoriasStacks]!
}
class CategoriasStacks: NSObject{
    var stack: UIStackView!
    var expedientes: [ExpedientesStacks]!
}
class ExpedientesStacks: NSObject{
    var stack: UIStackView!
    var item: ItemStacks!
}
class ItemStacks: NSObject{
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
