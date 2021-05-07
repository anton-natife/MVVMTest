//
//  TableViewCellDescription.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 07.05.2021.
//

import UIKit

class TableViewCellDescription: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(description: String) {
        
        self.descriptionLabel.text = description
    }
    
}
