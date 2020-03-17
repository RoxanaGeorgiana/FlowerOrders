//
//  OrdersListTableViewCell.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

class OrdersListTableViewCell: UITableViewCell {
    
    var topInset = CGFloat(0)
    var bottomInset = CGFloat(0)
    
    var order: OrderModel? {
        didSet {
            if let strUrl = order?.image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let imgUrl = URL(string: strUrl) {
                flowerImage.loadImageWithUrl(imgUrl)
            }
            flowerName.text = order?.flower
            if let price = order?.price {
                flowerPrice.text = String(format: "%.1f RON", price)

            }
        }
    }
    
    private let flowerName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let flowerPrice: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    private let flowerImage : ImageLoader = {
        let imgView = ImageLoader()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(flowerName)
        addSubview(flowerPrice)
        addSubview(flowerImage)
                
        addContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flowerImage.image = nil
        flowerName.text = nil
        flowerPrice.text = nil
    }
    
    func addContraints() {

        NSLayoutConstraint.activate([
            flowerImage.topAnchor.constraint(equalTo: topAnchor),
            flowerImage.leftAnchor.constraint(equalTo: leftAnchor),
            flowerImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            flowerImage.widthAnchor.constraint(equalToConstant: self.frame.width/2),

            flowerName.topAnchor.constraint(equalTo: topAnchor),
            flowerName.leftAnchor.constraint(equalTo: flowerImage.rightAnchor, constant: 5),
            flowerName.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            flowerPrice.topAnchor.constraint(equalTo: flowerName.bottomAnchor, constant: 5),
            flowerPrice.leftAnchor.constraint(equalTo: flowerImage.rightAnchor, constant: 5),
            flowerPrice.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)
            
        ])
        
    }
    
}
