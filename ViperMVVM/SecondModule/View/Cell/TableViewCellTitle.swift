//
//  TableViewCellTitle.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 07.05.2021.
//

import UIKit

class TableViewCellTitle: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(title: String) {
        
        self.titleLabel.text = title
    }
    
}
