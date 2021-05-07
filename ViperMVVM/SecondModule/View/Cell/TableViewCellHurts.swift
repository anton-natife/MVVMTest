//
//  TableViewCellHurts.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 07.05.2021.
//

import UIKit

class TableViewCellHurts: UITableViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var countHurt: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(countHurt: String, time: String) {
        
        self.countHurt.text = countHurt
        self.timeLabel.text = time
        self.imageImageView.image = UIImage(systemName: "heart.fill")
    }
    
}
