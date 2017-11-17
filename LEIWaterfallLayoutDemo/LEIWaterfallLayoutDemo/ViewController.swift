//
//  ViewController.swift
//  LEIWaterfallLayoutDemo
//
//  Created by app on 2017/11/16.
//  Copyright © 2017年 LEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,LEIWaterfallLayoutDelegate {
    var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*colNum:列数  rowSpacing：行距  colSpacing列距  */
        let waterLayout : LEIWaterfallLayout = LEIWaterfallLayout.init(colNum: 2, rowSpacing: 10, colSpacing: 10, sectionInset: UIEdgeInsetsMake(10, 10, 10, 10))
        /*设置代理*/
        waterLayout.delgate = self
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: waterLayout);
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "LEICollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cell")
          self.collectionView.register(UINib.init(nibName: "LEICollectionViewSortCell", bundle: Bundle.main), forCellWithReuseIdentifier: "sortCell")
        
        self.collectionView.backgroundColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(self.collectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*实现代理方法返回每个cell的高度*/
    func collectionView(heightOfCell layout: LEIWaterfallLayout, width: CGFloat, At indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 3 ? 210 : 280

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 3 {
            let cell : LEICollectionViewSortCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sortCell", for: indexPath) as! LEICollectionViewSortCell

            return cell

        }
        let cell : LEICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LEICollectionViewCell
  
        cell.imageView.image = UIImage.init(named: String(indexPath.row % 5) + ".jpg")
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击单元格")
        
        
        
    }
    
    

}

