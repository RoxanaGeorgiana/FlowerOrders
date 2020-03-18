//
//  NetworkManager.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

final class NetworkManager {
    
    private let urlString = "https://demo0091413.mockable.io/myflowers"
    
    var realmManager : RealmManager = RealmManager()
    var onFetchOrdersCompletion: ((_ orders: [OrderModel]) -> Void)?
    
    func fetchLocations() {
        if let url = URL(string:  urlString) {
            URLSession.shared.dataTask(with:url) { (data, response, error) in
                if let error = error {
                    print("Error while fetching locations: \(error)")
                    return
                }
                do {
                   if let dataResponse = data {
                    if let json = try? JSON(data: dataResponse, options: JSONSerialization.ReadingOptions.allowFragments) {
                           self.createNewLocation(json.arrayValue)
                       }
                   }
                }
            }.resume()
        }
    }
    
    func createNewLocation(_ orders: [JSON]) {
        var myOrders: [OrderModel] = []
        self.realmManager.realm.performInBackground(block: { realm in
            for item in orders {
                if let order = OrderModel.createFromJSON(params: item) {
                    realm.add(order, update: .all)
                    myOrders.append(order.viewModel())
                }
            }
        }, completion: {
            self.onFetchOrdersCompletion?(myOrders)
        })
    }
}
