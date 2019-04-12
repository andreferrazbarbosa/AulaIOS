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
    
    var items: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoRepository.all { (result) in
            switch result {
            case .success (let todos):
                self.items = todos
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.register(TodoItemCell.self,
                                   forCellReuseIdentifier: "todoItem")
                self.tableView.reloadData()
            case .error:
                print("Erro ao carregar")
            }
        }
    }
    
    
    private let todoRepository = TodoRepository (
        network: NetworkService(baseUrl:  "https://puc-dam-todolist.herokuapp.com"),
        token: "bBDSKLGCZYq2MyndrMLNqZ50kiVApCMlEvbWKVrCBG8="
    )
    
    
    @IBAction func btnAdd_Click(_ sender: Any) {
        let alertController = UIAlertController(title: "Nova tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) in textField.placeholder = "Tarefa"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in guard let task = alertController.textFields?.first?.text else { return }
            print(task)
            self.todoRepository.create(taskTitle: task, callback: { (result) in
                switch result{
                case .success(let itemTemp):
                    print(itemTemp)
                    self.items.append(itemTemp)
                    self.tableView.reloadData()
                case .error:
                    print("Erro no insert")
                }
            })
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
        
        
       // items[indexPath.row].isCompleted.toggle()
        //tableView.reloadData()
        
    }
    
    func tableView(_ _tableView:UITableView,trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
            let removeAction = UIContextualAction(
                style : .destructive,
                title: "Remover",
                handler: {(action, view, completionHandler) in
                    //remover item da lista
                    self.todoRepository.delete(id: self.items[indexPath.row].id!) { (result) in
                        switch result{
                        case .success:
                            self.items.remove(at: indexPath.row)
                            self.tableView.reloadData()
                        case .error:
                            print("Erro ao remover")
                        }
                        
                        completionHandler(true)
                    }
                    completionHandler(true)
            }
            )
            let swipeConfiguration = UISwipeActionsConfiguration(actions :[removeAction])
            return swipeConfiguration
    }
    
    func tableView(_ _tableView:UITableView,leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
        UISwipeActionsConfiguration? {
            let removeAction = UIContextualAction(
                style : .normal,
                title: "Realizada",
                handler: {(action, view, completionHandler) in
                    //Concluir item da lista
                    self.todoRepository.toggleComplete(id: self.items[indexPath.row].id!, callback: { (result) in
                        switch result{
                        case .success(let itemTemp):
                            self.items.remove(at: indexPath.row)
                            self.items.insert(itemTemp, at: indexPath.row)
                            self.tableView.reloadRows(at: [indexPath], with: .fade)
                        case .error:
                            print("Erro ao concluir")
                        }
                    })
                    
                    completionHandler(true)
            }
            )
            
            let swipeConfiguration = UISwipeActionsConfiguration(actions :[removeAction])
            return swipeConfiguration
            
            
    }
    
}

