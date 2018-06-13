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
    var inputTexts: [String] = ["Start date", "End date", "Another date"]
    var inputDates: [Date] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInitailValues()
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), style: .grouped)
        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: DateTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DateTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: DatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DatePickerTableViewCell.reuseIdentifier())
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: inputTexts.count)
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
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
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.delegate = self
            return datePickerCell
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier()) as! DateTableViewCell
            dateCell.updateText(text: inputTexts[indexPath.row], date: inputDates[indexPath.row])
            return dateCell
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
            tableView.deselectRow(at: indexPath, animated: true)
        }
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

extension ViewController: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
