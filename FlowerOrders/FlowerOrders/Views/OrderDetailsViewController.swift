//
//  OrderDetailsViewController.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 17/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    var order: OrderModel? {
        didSet {
            if let strUrl = order?.image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let imgUrl = URL(string: strUrl) {
                flowerImage.loadImageWithUrl(imgUrl)
            }
            flowerName.text = order?.flower
            
            if let deliver = order?.deliver_to {
                deliverTo.text = "\("Deliver To: ") \(deliver)"
            }
            if let orderPrice = order?.price {
                price.text = String(format: "Price:  %.1f  RON", orderPrice)
            }
            if let address = order?.address {
                orderAddress.text = "\("Address: ") \(address)"
            }
        }
    }
    
    private let flowerImage : ImageLoader = {
        let imgView = ImageLoader()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let flowerName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deliverTo : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let price : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let orderAddress : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(flowerImage)
        view.addSubview(flowerName)
        view.addSubview(deliverTo)
        view.addSubview(price)
        view.addSubview(orderAddress)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let constraints:[NSLayoutConstraint] = [
            flowerImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            flowerImage.heightAnchor.constraint(equalTo: view.widthAnchor),
            flowerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            flowerName.topAnchor.constraint(equalTo: flowerImage.bottomAnchor, constant: 20),
            flowerName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            flowerName.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            deliverTo.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 10),
            deliverTo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            deliverTo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            price.topAnchor.constraint(equalTo: deliverTo.bottomAnchor, constant: 10),
            price.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            price.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            
            orderAddress.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 10),
            orderAddress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            orderAddress.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)]
        NSLayoutConstraint.activate(constraints)
    }
}
