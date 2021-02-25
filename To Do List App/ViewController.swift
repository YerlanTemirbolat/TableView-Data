//
//  ViewController.swift
//  To Do List App
//
//  Created by Admin on 1/28/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                             target: self,
                                                             action: #selector(didTapAdd))
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new to do item", preferredStyle: .alert)
        alert.addTextField { (field) in
            field.placeholder = "Enter item..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self](_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey: "items")
                        self?.items.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}












//func setViewConstraints() {
//    NSLayoutConstraint.activate([
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 91),
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22)
//    ])
//
//    NSLayoutConstraint.activate([
//        labelSecond.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
//        labelSecond.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 72),
//        labelSecond.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60)
//    ])
//
//    NSLayoutConstraint.activate([
//        textField.topAnchor.constraint(equalTo: labelSecond.bottomAnchor, constant: 68),
//        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
//        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
//    ])
//
//    NSLayoutConstraint.activate([
//        textFieldSecond.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 47),
//        textFieldSecond.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
//        textFieldSecond.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
//    ])
//
//    NSLayoutConstraint.activate([
//        labelThird.topAnchor.constraint(equalTo: textFieldSecond.bottomAnchor, constant: 100),
//        labelThird.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
//        labelThird.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46)
//    ])
//
//    NSLayoutConstraint.activate([
//        button.topAnchor.constraint(equalTo: labelThird.bottomAnchor, constant: 38),
//        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
//        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
//        button.heightAnchor.constraint(equalToConstant: 55)
//    ])
