//
//  TableViewCellImage.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 07.05.2021.
//

import UIKit

class TableViewCellImage: UITableViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: Data) {
        
        self.imageImageView.image = UIImage(data: data)
        
//        if image != nil {
//            curentImageView.image = image
//            let imWidth = image?.size.width
//            let imHeight = image?.size.height
//            let ratio = imHeight! / imWidth!
//            self.heightContraint?.constant = width! * ratio
//            self.layoutIfNeeded()
//        }
    }
    
}
