//
//  OrdersListView.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import UIKit

class OrdersListView: UIView {
    
    private struct Constants {
        static let rowHeight: CGFloat = 160.0
    }
    var isSetup = false
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.rowHeight = Constants.rowHeight
        tv.separatorStyle = .none
        tv.separatorInset = UIEdgeInsets.zero
        tv.layoutMargins = UIEdgeInsets.zero
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Initialisers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        isSetup = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open  func awakeFromNib() {
        super.awakeFromNib()
        if !isSetup {
            setup()
            setupConstraints()
            isSetup = true
        }
    }

    // MARK: - Setup
    
    func setup() {
        addSubview(tableview)
    }

    // MARK: - Constraints
    
    func setupConstraints() {
        tableview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
