//
//  TableViewCell.swift
//  RadiusTask
//
//  Created by ADMIN on 28/06/23.
//  Copyright © 2023 Kiwitech. All rights reserved.
//

import UIKit

// MARK: - ViewModel

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioBtnLbl: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var selectionHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with option: Option) {
        nameLabel.text = option.name
        photoView.image = UIImage(named: option.icon)
    }
    
    @IBAction func radioBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        selectionHandler?()
    }
}
