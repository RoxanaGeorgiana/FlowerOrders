//
//  AllOrdersViewModel.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 18/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import Foundation

class AllOrdersViewModel {

    let networkManager: NetworkManager

    var ordersCellsViewModels: [OrderModel] = [OrderModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var reloadTableView: (()->())?
        
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        initFetch()
    }
    
    func initFetch() {
        networkManager.fetchLocations()
        networkManager.onFetchOrdersCompletion = { [weak self] orders in
            self?.ordersCellsViewModels = orders
        }
    }
    
    func getOrdersCellsViewModel(_ cell: Int) -> OrderModel {
        return ordersCellsViewModels[cell]
    }
}
