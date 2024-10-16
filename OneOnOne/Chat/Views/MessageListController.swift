//
//  MessageListController.swift
//  OneOnOne
//
//  Created by Vlad on 12/10/24.
//

import Foundation
import UIKit
import SwiftUI

/*
 Организует содержимое списка, настраивает внешний вид каждой строки и отвечает за то, как эти данные будут отображаться пользователю.
 Organizes the contents of the list, customizes the appearance of each row, and is responsible for how this data will be displayed to the user.
 */
final class MessageListController: UIViewController {
    
    // MARK: - View's LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Properties
    /*
      Идентификатор ячейки, который будет использоваться для повторного использования ячеек таблицы (cell reuse).
      Cell identifier that will be used for cell reuse.
     */
    private let cellIdentifier = "MessageListControllerCells"
    
    /*
     Инициализация таблицы. Она создается как ленивое свойство (lazy),
     что означает, что объект tableView будет инициализирован только при первом обращении к нему.
     Table initialization. It is created as a lazy property,
     which means that the tableView object will only be initialized the first time it is accessed.
     */
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Methods
    /*
     Функция для настройки и добавления tableView на главный view контроллера
     Function for setting up and adding tableView to the main view of the controller
     */
    private func setUpViews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension MessageListController: UITableViewDelegate, UITableViewDataSource {
    /*
     Метод для создания и настройки ячейки для строки таблицы
     Это повышает производительность, так как ячейки могут быть переиспользованы при прокрутке таблицы.
     
     Method for creating and setting up a cell for a table row
     This improves performance because cells can be reused as the table is scrolled.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let message = MessageItem.stubMessages[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration {
            switch message.type {
            case .text:
                BubbleTextView(item: message)
            case .photo, .video:
                BubbleImageView(item: message)
            case .audio:
                BubbleAudioView(item: message)
            }
        }
        return cell
    }
    
    /*
     Этот метод сообщает таблице, сколько строк должно быть в секции.
     This method tells the table how many rows should be in the section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageItem.stubMessages.count
    }
    
    /*
     Метод, который указывает высоту для каждой строки.
     Мы используем `UITableView.automaticDimension`, чтобы таблица автоматически рассчитывала высоту ячейки
     на основе ее содержимого.
     
     A method that specifies the height for each line.
     We use `UITableView.automaticDimension` to have the table automatically calculate the cell height
     based on its content.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

#Preview {
    MessageListView()
}
