//
//  ViewController.swift
//  InlineDatePicker
//
//  Created by Rajtharan Gopal on 07/06/18.
//  Copyright © 2018 Rajtharan Gopal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var datePickerIndexPath: IndexPath?
    var inputTexts = ["A", "B", "C"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), style: .grouped)
        view.addSubview(tableView)
        
        tableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.reuseIdentifier())
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier())
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return IndexPath(row: indexPath.row, section: indexPath.section)
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return inputTexts.count + 1
        } else {
            return inputTexts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseIdentifier()) as! DatePickerTableViewCell
            return datePickerCell
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier()) as! DateTableViewCell
            dateCell.updateText(text: inputTexts[indexPath.row])
            return dateCell
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
        }
        datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
        tableView.insertRows(at: [datePickerIndexPath!], with: .bottom)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DateTableViewCell.cellHeight()
        }
    }
    
}
