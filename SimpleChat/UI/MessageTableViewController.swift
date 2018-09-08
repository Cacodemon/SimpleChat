//
//  MessageTableViewController.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

class MessageTableViewController: UIViewController {
  
  private var viewModel: MessageListViewModel!
  
  var messageTableView: MessageTableView {
    return view as! MessageTableView
  }
  
  init(_ viewModel: MessageListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("not implemented")
  }
  
  override func loadView() {
    let messageTableView = MessageTableView()
    messageTableView.tableView.dataSource = self
    messageTableView.tableView.delegate = self
    messageTableView.textField.delegate = self
    view = messageTableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewModel()
  }
  
  func setupViewModel() {
    
    viewModel.reloadTableView = { [weak self] () in
      DispatchQueue.main.async {
        self?.messageTableView.tableView.reloadData()
      }
    }
    
    viewModel.beginLoading = { [weak self] () in
      DispatchQueue.main.async {
        self?.messageTableView.activityIndicator.startAnimating()
        self?.messageTableView.tableView.alpha = 0.0
      }
    }
    
    viewModel.endLoading = { [weak self] () in
      DispatchQueue.main.async {
        self?.messageTableView.activityIndicator.stopAnimating()
        self?.messageTableView.tableView.alpha = 1.0
      }
    }
    
    viewModel.setup()
  }
}

extension MessageTableViewController: UITableViewDelegate {
  
}

extension MessageTableViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfMessages
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier) as! MessageTableViewCell
    cell.messageViewModel = viewModel.messageViewModel(at: indexPath)
    return cell
  }
}

extension MessageTableViewController: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text else { return }
    guard !text.isEmpty else { return }
    viewModel.enterText(text)
    textField.text = nil
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
