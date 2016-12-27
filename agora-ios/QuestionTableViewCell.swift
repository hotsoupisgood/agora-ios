//
//  questionTableViewCell.swift
//  agora-ios
//
//  Created by Mac on 12/21/16.
//  Copyright © 2016 This Agora. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var questionTextView: UITextView!
    var tagArray  = NSArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        print(tagArray)
    }
    //MARK: Actions
//    @IBAction func answerButtonTouch(_ sender: UIButton) {
}

extension QuestionTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count: \(tagArray.count)")
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath as IndexPath) as? TagCollectionViewCell
        if tagArray.count != 0 {
            if let tagDict = tagArray[indexPath.row] as? NSDictionary {
                if let tagText = tagDict["name"] as? String
                {
                    cell?.tagLabel.text = tagText
                }
            }
        }
        
        return cell!
    }
    
}

//extension QuestionTableViewCell : UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 4
//        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//    
//}
