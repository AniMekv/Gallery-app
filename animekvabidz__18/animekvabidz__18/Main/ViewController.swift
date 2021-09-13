//
//  ViewController.swift
//  animekvabidz__18
//
//  Created by Mac User on 5/24/21.
//

import UIKit
import  Kingfisher

class ViewController: UIViewController {
    enum Mode {
        case view
        case select
    }
    
    private var cellCount = 0


    @IBOutlet weak var collectionView: UICollectionView!
    
    let countCells = 3
    let offset: CGFloat = 2.0
    
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
    

    var mMode: Mode = .view {
        didSet {
        switch mMode {
          case .view:
            for (key, value) in dictionarySelectedIndecPath {
              if value {
                collectionView.deselectItem(at: key, animated: true)
              }
            }
            
            dictionarySelectedIndecPath.removeAll()
            
            selectBarButton.title = "Select"
            navigationItem.leftBarButtonItem = nil
            collectionView.allowsMultipleSelection = false
          case .select:
            selectBarButton.title = "Cancel"
            navigationItem.leftBarButtonItem = deleteBarButton
            collectionView.allowsMultipleSelection = true
          }
        }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupBarButtonItems()
        
        cellCount = UserDefaults.standard.integer(forKey: "cell_count")
//        cellCount = Int(imageList.count)
//        UserDefaults.standard.set(cellCount, forKey: "cell_count")
//        collectionView.reloadData()
       


    }
    
  
      
      lazy var selectBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtonItem
      }()

      lazy var deleteBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
        return barButtonItem
      }()
    
    var dictionarySelectedIndecPath: [IndexPath: Bool] = [:]
    
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = selectBarButton
      }
    

    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
        mMode = mMode == .view ? .select : .view
      }
      
    
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
        var deleteNeededIndexPaths: [IndexPath] = []
        for (key, value) in dictionarySelectedIndecPath {
          if value {
            deleteNeededIndexPaths.append(key)
          }
        }
        
        for i in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
          imageList.remove(at: i.item)
        }
        
        collectionView.deleteItems(at: deleteNeededIndexPaths)
        dictionarySelectedIndecPath.removeAll()
        
        cellCount = Int(imageList.count)
        UserDefaults.standard.set(cellCount, forKey: "cell_count")
        collectionView.reloadData()
      }
    


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell

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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
            case .view:
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        vc.imageList = imageList
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
        case .select:
            dictionarySelectedIndecPath[indexPath] = true
        }
        
    }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if mMode == .select {
              dictionarySelectedIndecPath[indexPath] = false
            }
      }
   }

    


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame.size
        
        let withCell = frameCV.width / CGFloat(countCells)
        let  heightCell = withCell
        
        let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        return CGSize(width: withCell - spacing, height: heightCell - (offset*2))
    }
    
    
}


