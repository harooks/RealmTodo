//
//  ViewController.swift
//  SimpleTodo
//
//  Created by Haruko Okada on 1/23/21.
//

import RealmSwift
import UIKit


class TodoItem: Object {
//    @objc dynamic var id: Int = 0
    @objc dynamic var item: String = ""
    @objc dynamic var time: Double = 0.0
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let realm = try! Realm()
    var todoArray = [TodoItem]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        


        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm()
        todoArray = realm.objects(TodoItem.self).map({ $0 })
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell
        cell.titleLabel.text = todoArray[indexPath.row].item
        cell.durationLabel.text = String(Int(todoArray[indexPath.row].time / 60))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButton(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "NewItem") as? AddViewController else {
            return
        }
        
        vc.title = "New Item"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            deleteTodo(at:indexPath.row)
            tableView.reloadData()
        }
    }

    func deleteTodo(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(todoArray[index])
        }
    }




}
