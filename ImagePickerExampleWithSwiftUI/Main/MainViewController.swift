//
//  ViewController.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/16.
//  Copyright © 2020 Seokho. All rights reserved.
//

import SwiftUI
import Combine

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    private let dataManager: DataManager
    private var cancel = Set<AnyCancellable>()
    
    private var tableView: UITableView {
        guard let tableView = self.view as? UITableView else {
            preconditionFailure()
        }
        return tableView
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.viewModel = MainViewModel(dataManager: dataManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        view.tableFooterView = UIView()
        view.dataSource = self
        view.delegate = self
        view.register(MainCell.self, forCellReuseIdentifier: "\(MainCell.self)")
        self.view = view
        self.navigationItem.title = "Main"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddViewController))
        
        self.viewModel.$cellModel
            .receive(on: DispatchQueue.main)
            .filter({ $0.count == self.dataManager.images.count})
            .sink { _ in
                self.tableView.reloadData()
        }.store(in: &cancel)
    }
    
    
    @objc
    private func presentAddViewController() {
        let viewMdoel = AddViewModel(dataManager: self.dataManager)
        let view = UIHostingController(rootView: AddView(viewController: self, viewModel: viewMdoel))
        self.present(view, animated:  true)
    }
    
}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModel.cellModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: viewModel).reuseIdentifier, for: indexPath)
        
        switch (cell, viewModel) {
        case let (cell, viewModel) as (MainCell, MainCellViewModel):
            cell.viewModel = viewModel
        default:
            fatalError()
        }
        
        return cell
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetData = self.dataManager.images[indexPath.row]
        guard let title = targetData.title,
            let data = targetData.image,
            let image = UIImage(data: data) else { return }
       
        self.dataManager.modifyInfomation = ModifyInfomation(type: .amend, index: indexPath.row)
        let viewMdoel = AddViewModel(dataManager: self.dataManager)
        viewMdoel.title = title
        viewMdoel.image = image
        let view = UIHostingController(rootView: AddView(viewController: self, viewModel: viewMdoel))
        self.present(view, animated:  true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, _) in
            self.dataManager.modifyInfomation = ModifyInfomation(type: .delete, index: indexPath.row)
        }

        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
            
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
