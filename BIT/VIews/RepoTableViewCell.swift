//
//  RepoTableViewCell.swift
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    
    @IBOutlet weak var bodyView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBodyView()
        setupShadowView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupShadowView() {
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 2.6
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    private func setupBodyView() {
        bodyView.layer.cornerRadius = 14.0
        bodyView.clipsToBounds = true
    }
}
