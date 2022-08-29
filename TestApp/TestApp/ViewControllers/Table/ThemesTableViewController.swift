//
//  ThemesTableViewController.swift
//  TestApp
//
//  Created by Melanie Kofman on 29.08.2022.
//

import Foundation
import UIKit
class ThemesTableViewController: UITableViewController {
    var data: [String] = ["Авто", "Бизнес", "Инвестиции", "Спорт", "Саморазвитие", "Здоровье",
                          "Еда", "Семья, дети", "Домашние питомцы", "Фильмы", "Компьютерные игры",
                          "Музыка",]
    var selectedData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CellTable.self, forCellReuseIdentifier: CellTable.id)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellTable.id, for: indexPath) as! CellTable
        cell.configure(with: data[indexPath.row])

        return cell
    }
}
