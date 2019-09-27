//
//  TodoeyTableViewController.swift
//  Todoey
//
//  Created by Do Hung on 9/26/19.
//  Copyright © 2019 Do Hung. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        /*UserDefaults*/
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        if let decodedArray = defaults.data(forKey: "TodoListArray") {
            if #available(iOS 12.0, *) {
                guard let items = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedArray) as? [Item] else { return }
                itemArray = items
            } else {
                guard let items = NSKeyedUnarchiver.unarchiveObject(with: decodedArray) as? [Item] else { return }
                itemArray = items
            }
        } else {
            itemArray.append(Item(title: "Find Mike", done: false))
            itemArray.append(Item(title: "Buy Eggos", done: false))
            itemArray.append(Item(title: "Destroy Demogorgon", done: false))
            itemArray.append(Item(title: "Find Mike", done: false))
        }
    }

    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    // MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let item = Item(title: textField.text!, done: false)
            self.itemArray.append(item)
            
            /*UserDefaults*/
            if #available(iOS 11.0, *) {
                do {
                    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: self.itemArray, requiringSecureCoding: false)
                    self.updateData(data: encodedData)
                } catch {
                    print(error)
                }
            } else {
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.itemArray)
                self.updateData(data: encodedData)
            }
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateData(data: Data) {
        self.defaults.set(data, forKey: "TodoListArray")
        self.defaults.synchronize()
    }
}
