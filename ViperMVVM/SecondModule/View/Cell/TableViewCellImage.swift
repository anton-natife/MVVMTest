//
//  TableViewCellImage.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 07.05.2021.
//

import UIKit

class TableViewCellImage: UITableViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    @IBOutlet weak var heightImage: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(data: Data?, width: CGFloat?) {
        if let data = data, let width = width, let image = UIImage(data: data) {
            
            self.imageImageView.image = image
            let imWidth = image.size.width
            let imHeight = image.size.height
            let ratio = imHeight / imWidth
            self.heightImage?.constant = width * ratio
            self.layoutIfNeeded()
        } else if let image = UIImage(named: "not found"), let width = width {
            
            self.imageImageView.image = image
            self.imageImageView.backgroundColor = .systemGray4
            let imWidth = image.size.width
            let imHeight = image.size.height
            let ratio = imHeight / imWidth
            self.heightImage?.constant = width * ratio
            self.layoutIfNeeded()
        }
    }
}
