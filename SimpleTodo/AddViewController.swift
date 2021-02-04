//
//  AddViewController.swift
//  SimpleTodo
//
//  Created by Haruko Okada on 1/23/21.
//

import RealmSwift
import UIKit

class AddViewController: UIViewController, UITextFieldDelegate{
    
    var completionHander: (() -> Void)?
    
    var todo: TodoItem?
    
    let realm = try! Realm()
    
    @IBOutlet weak var todoText: UITextField!
    
    @IBOutlet weak var todoTimePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            todoText.text = todo.item
            todoTimePicker.countDownDuration = todo.time
        }

    
    }

    
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let title = todoText.text else {
            return
        }
        
        let updateTodo: TodoItem
        if let todo = todo {
            updateTodo = todo
        } else {
            updateTodo = TodoItem()
        }
        
        try! realm.write {
            
            updateTodo.item = title
            updateTodo.time = todoTimePicker.countDownDuration
            realm.add(updateTodo)
        }

//        let text = todoText.text
//        if text != nil {
//            let pickedTime = todoTimePicker.countDownDuration
//            let realm = try! Realm()
//
//
//            let newItem = TodoItem()
//            newItem.time = pickedTime
//            newItem.item = text!
//
//            try! realm.write {
//            realm.add(newItem)
//            }
//           // try! realm.commitWrite()
//        }
//
//        completionHander?()
//        navigationController?.popViewController(animated: true)
    }

}
