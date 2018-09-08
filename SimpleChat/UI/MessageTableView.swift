//
//  MessageTableView.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/8/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

class MessageTableView: UIView {
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.keyboardDismissMode = .onDrag
    tableView.register(MessageTableViewCell.self,
                       forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
    return tableView
  }()
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .lightGray
    textField.placeholder = "Message"
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  private func setupView() {
    
    backgroundColor = .white
    
    addSubview(tableView)
    addSubview(textField)
    addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      
      textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      
      tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
}
