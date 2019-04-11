//
//  ViewController.swift
//  TodoList
//
//  Created by user151729 on 4/2/19.
//  Copyright © 2019 user151729. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(TodoItemCell.self,
                           forCellReuseIdentifier: "todoItem")
    }
    
    struct Todo {
        var task : String
        var isCompleted : Bool
        
        init(task: String){
            self.task = task
            self.isCompleted = false
        }
    }
    
    var items: [Todo] = [
        Todo(task: "Terminar Exercícios de iOS"),
        Todo(task: "Trocar android por um iPhone"),
        Todo(task: "Comprar um Macbook"),
    ]
    
    
    @IBAction func btnAdd_Click(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        alert.addTextField{(textField) in textField.placeholder = "Tarefa"}
        
        var itemAtual  = self.items
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(_) in
            guard let task = alert.textFields?.first?.text else {return}
            
            itemAtual.insert(Todo(task: task),at: 0)
            self.items = itemAtual
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) as? TodoItemCell else { fatalError() }
        
        cell.textLabel?.text = items[indexPath.row].task
        cell.isCompleted = items[indexPath.row].isCompleted
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction (
            style: .destructive,
            title: "Remover",
            handler: {(action, view, completionHandler) in
                self.items.remove(at: indexPath.row)
                self.tableView.reloadData()
                completionHandler(true)
        })
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        return swipeConfiguration
    }
    
}

