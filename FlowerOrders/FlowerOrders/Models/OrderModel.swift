//
//  OrderModel.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

public class OrderModel: Object {
    
    @objc dynamic public var id: String!
    @objc dynamic public var flower: String!
    @objc dynamic public var deliver_to: String!
    @objc dynamic public var address: String!
    @objc dynamic public var image: String!
    @objc dynamic public var price: Double = 0.0
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public func viewModel() -> OrderModel {
        return OrderModel(value: self)
    }
    
    public convenience init?(_ id: String, _ flower: String, _ deliverTo: String, _ image: String, _ price: Double, _ address: String) {
        self.init()
        self.id = id
        self.flower = flower
        self.deliver_to = deliverTo
        self.image = image
        self.price = price
        self.address = address
    }
    
    class func createFromJSON(params: JSON) -> OrderModel? {
        //TODO: Create DataLocation object

        guard let id = params["id"].rawString(),
            let flower = params["flower"].rawString(),
            let deliverTo = params["deliver_to"].rawString(),
            let image = params["image"].rawString(),
            let priceString = params["price"].rawString(),
        let address = params["address"].rawString() else { return nil }
        guard let price = Double(priceString) else { return nil }
        
        return OrderModel(id, flower, deliverTo, image, price, address)
    }
    
    static public func currentLocation(dataStore: RealmManager) -> OrderModel? {
        return dataStore.realm.objects(OrderModel.self).first?.viewModel()
    }
}
