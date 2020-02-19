//
//  ViewController.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import UIKit

final class RandomUserListViewController: UIViewController {
    
    fileprivate var tableView: UITableView!
    fileprivate var viewModel: RandomUserListViewModel!
    
    static func instantiate(with viewModel: RandomUserListViewModel) -> RandomUserListViewController {
        let viewController = RandomUserListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = makeTableView()
        loadTableViewData()
    }
    
    private func loadTableViewData() {
        viewModel.fetchBunchOfRandomUser { [weak self] (success, error) in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.manageAlertError(with: error)
            }
        }
    }
    
    private func loadMoreTableViewData() {
        viewModel.fetchMoreRandomUsers { [weak self] (success, error) in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.manageAlertError(with: error)
            }
        }
    }
    
    private func manageAlertError(with error: Error?) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(
                title: "Error",
                message: "Error when fetching data from the api: \(error?.localizedDescription ?? "unknown error")",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (_) in
                self?.loadTableViewData()
            }))
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

extension RandomUserListViewController: UITableViewDataSource {
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        let randomUserCellNib = UINib(nibName: String(describing: RandomUserTableViewCell.self), bundle: nil)
        tableView.register(randomUserCellNib, forCellReuseIdentifier: RandomUserTableViewCell.cellIdentifier)
        return tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RandomUserTableViewCell.cellIdentifier) as? RandomUserTableViewCell else {
            fatalError("Error Dequeue Reusable Cell. Identifier is probably wrong.")
        }
        cell.fill(with: viewModel.elementAt(indexPath))
        return cell
    }
}

extension RandomUserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isLastElement(for: indexPath.row) {
            loadMoreTableViewData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let randomUser = viewModel.elementAt(indexPath)
        
        let userRandomDetailsViewController = RandomUserDetailsViewController.instantiate(with: randomUser)
        navigationController?.pushViewController(userRandomDetailsViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

