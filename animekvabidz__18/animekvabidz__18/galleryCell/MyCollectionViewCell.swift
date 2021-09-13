//
//  MyCollectionViewCell.swift
//  animekvabidz__18
//
//  Created by Mac User on 5/24/21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var ImageView: UIImageView!
    static var identifier   = "MyCollectionViewCell"
    
    @IBOutlet weak var highlightIndicator: UIView!
    
    @IBOutlet weak var selectIndicator: UIImageView!
    
    override var isHighlighted: Bool {
        didSet {
          highlightIndicator.isHidden = !isHighlighted
        }
      }
      
      override var isSelected: Bool {
        didSet {
          highlightIndicator.isHidden = !isSelected
          selectIndicator.isHidden = !isSelected
        }
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func conficure(with image: UIImage){
        ImageView.image = image
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
