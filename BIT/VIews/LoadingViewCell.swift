//
//  LoadingViewCell.swift
//  BIT
//
//  Created by Miska  on 19/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import UIKit

class LoadingViewCell: UITableViewCell {

    var activityIndicator: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
           fatalError()
       }
    
    private func setupViews(){
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .gray
        }
        indicator.hidesWhenStopped = true
        indicator.center = CGPoint(x: 210, y: 30)
        contentView.addSubview(indicator)
        indicator.startAnimating()
    }

}
