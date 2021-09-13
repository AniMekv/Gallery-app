//
//  FullScreenViewController.swift
//  animekvabidz__18
//
//  Created by Mac User on 5/24/21.
//

import UIKit
import  Kingfisher

class FullScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let countCells = 1
    var indexPath: IndexPath!
    
    var imageList = [
        "https://images3.alphacoders.com/877/877183.jpg",
        "https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZmVybnxlbnwwfHwwfHw%3D&w=1000&q=80",
        "https://images3.alphacoders.com/375/thumb-1920-375.jpg",
        "https://cdn.hipwallpaper.com/i/90/78/4RLbmZ.jpg",
        "https://i.pinimg.com/originals/5a/19/ae/5a19aedd954743acb95b1786068f7b3b.jpg",
        "https://images.pexels.com/photos/556666/pexels-photo-556666.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "https://numpaint.com/wp-content/uploads/2020/08/japan-autumn-season-paint-by-number.jpg",
        "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg"
    ]


    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(fullScreenCell.nib(), forCellWithReuseIdentifier: fullScreenCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    

}

extension FullScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       //return  photoGallery.count
        return  imageList.count

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fullScreenCell.identifier, for: indexPath) as! fullScreenCell
    
            cell.ImageView.kf.setImage(with: URL(string: self.imageList[indexPath.row]),
                                       placeholder: UIImage(named: "placeholderImage"),
                                                           options: [
                                                               .scaleFactor(UIScreen.main.scale),
                                                               .transition(.fade(1)),
                                                               .cacheOriginalImage
                                                           ])
                                                       {
                                                           result in
                                                           switch result {
                                                           case .success(let value):
                                                               print("Task done for: \(value.source.url?.absoluteString ?? "")")
                                                           case .failure(let error):
                                                               print("Job failed: \(error.localizedDescription)")
                                                           }
                                                       }
 
            return cell
            
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame.size
        
        let withCell = frameCV.width / CGFloat(countCells)
        let  heightCell = withCell
                return CGSize(width: withCell, height: heightCell)
        
    }

}
