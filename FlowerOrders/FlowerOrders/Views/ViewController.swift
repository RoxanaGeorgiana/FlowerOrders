//
//  OrdersListViewController.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    var viewModel: AllOrdersViewModel!

    fileprivate var contentView: OrdersListView { return self.view as! OrdersListView }
    fileprivate let kCellIdentifier = "ListOrderCell"
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupTableView()
    }

    private func setupTableView() {
        let view = OrdersListView()
        view.tableview.delegate = self
        view.tableview.dataSource = self
        view.tableview.register(OrdersListTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.view = view
    }
    
    private func initViewModel() {
        viewModel = AllOrdersViewModel()
        viewModel.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.contentView.tableview.reloadData()
            }
        }
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ordersCellsViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? OrdersListTableViewCell else {
            assert(false, "Invalid table view cell. Did you forget to register ArtistTableViewCell?")
            return UITableViewCell()
        }
        let orderModel = viewModel.ordersCellsViewModels[indexPath.row]
        cell.order = orderModel

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let orderDetail = OrderDetailsViewController()
        orderDetail.order = viewModel.ordersCellsViewModels[indexPath.row]
        
        self.navigationController?.pushViewController(orderDetail, animated: true)
    }
}
