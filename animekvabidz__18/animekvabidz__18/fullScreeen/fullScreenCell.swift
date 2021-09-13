//
//  fullScreenCell.swift
//  animekvabidz__18
//
//  Created by Mac User on 5/24/21.
//

import UIKit

class fullScreenCell: UICollectionViewCell {
    
    @IBOutlet var ImageView: UIImageView!

    static var identifier   = "fullScreenCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func conficure(with image: UIImage){
        ImageView.image = image
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "fullScreenCell", bundle: nil)
    }

}
