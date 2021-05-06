//
//  FirstTableViewCell.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 05.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

class FirstTableViewCell: UITableViewCell {
    
    static let cellIdentifer = "FirstTableViewCell"
    private var isExpanded: Bool = false
    var callback: (() -> Void)?

    var action: ControlEvent<Void> {
        return presentButton.rx.tap
    }
    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var presentButton: UIButton!
    @IBOutlet weak var hurtImageView: UIImageView!
    @IBOutlet weak var countHurtLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override var frame: CGRect {
//            get {
//                return super.frame
//            }
//            set (newFrame) {
//                var frame =  newFrame
//                frame.origin.y += 4
//                frame.size.height -= 2 * 5
//                super.frame = frame
//            }
//        }
   
    @IBAction func showText(_ sender: UIButton) {
        isExpanded.toggle()
        callback?()
    }
    
    func fill(state: State) {
      
        descriptionLabel.numberOfLines = state.isExpanded ? 0 : 2
        titleLabel.text = state.comment.title
        descriptionLabel.text = state.comment.previewText
        countHurtLabel.text = state.comment.likesCount?.description
        hurtImageView.image = UIImage(systemName: "heart.fill")
        
        if let dateString = state.comment.timeshamp {
            let date = Date(timeIntervalSince1970: dateString)
            timeLabel.text = date.amountMinutsFrom() + "  назад"
        
        } else {
            timeLabel.text = ""
        }
//        self.layoutIfNeeded()
    }
    
}
