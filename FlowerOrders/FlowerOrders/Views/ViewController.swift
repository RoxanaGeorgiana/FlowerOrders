//
//  OrdersListViewController.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager : NetworkManager = NetworkManager()

    fileprivate var ordersViewModels: [OrderModel] = []    
    fileprivate var contentView: OrdersListView { return self.view as! OrdersListView }
    fileprivate let kCellIdentifier = "ListOrderCell"

    // MARK: - View lifecycle
    
    override func loadView() {
        
        self.setupTableView()
        
        networkManager.fetchLocations()
        networkManager.onFetchOrders = { [weak self] orders in
            self?.refresh(orders)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupTableView() {
        let view = OrdersListView()
        view.tableview.delegate = self
        view.tableview.dataSource = self
        view.tableview.register(OrdersListTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.view = view
    }
    
    @objc func refresh(_ orders: [OrderModel]) {
        self.ordersViewModels = orders
        contentView.tableview.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? OrdersListTableViewCell else {
            assert(false, "Invalid table view cell. Did you forget to register ArtistTableViewCell?")
            return UITableViewCell()
        }
        let orderModel = ordersViewModels[indexPath.row]
        cell.order = orderModel

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let orderDetail = OrderDetailsViewController()
        orderDetail.order = ordersViewModels[indexPath.row]
        
        self.navigationController?.pushViewController(orderDetail, animated: true)
    }
}
