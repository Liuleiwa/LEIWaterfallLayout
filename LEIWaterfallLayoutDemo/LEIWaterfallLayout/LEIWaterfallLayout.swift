//
//  LEIWaterfallLayout.swift
//  LEIWaterfallLayoutDemo
//
//  Created by app on 2017/11/16.
//  Copyright © 2017年 LEI. All rights reserved.
//

import UIKit
//定义一个协议
protocol LEIWaterfallLayoutDelegate : NSObjectProtocol {
    func collectionView(heightOfCell layout : LEIWaterfallLayout, width : CGFloat, At indexPath : IndexPath) -> CGFloat
}
class LEIWaterfallLayout: UICollectionViewLayout {
/*总共多少列*/
    var col_num : NSInteger = NSInteger()
    
/*列间距*/
    
    var col_spacing : CGFloat = CGFloat()
    
/*行间距*/
    
    var row_spacing : CGFloat = CGFloat()
/*设置sectionInset*/
    
    var section_inset : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    
    weak var  delgate : LEIWaterfallLayoutDelegate?
    
/*用来记录每一列的最大y值*/

    lazy var max_y_dict : Dictionary = {
        
        return Dictionary<NSNumber, NSNumber>()
        
    }()
/*存储每个单元格的attributes*/
    lazy var attributes_array : Array = {
        
        return Array<UICollectionViewLayoutAttributes>()
        
    }()
/*重写get方法，计算collectionview的contentsize*/
    override var collectionViewContentSize: CGSize{
        get{
                    var max_index : NSNumber = 0
            
                    for (key, value) in self.max_y_dict {
                        if (self.max_y_dict[max_index]?.floatValue)! < value.floatValue{
                            max_index = key
                        }
                    }
                    let height : CGFloat = CGFloat( truncating: self.max_y_dict[max_index]!) + CGFloat(self.section_inset.bottom)
                    return CGSize.init(width: 0, height: height)
        }
    }
    
    convenience init(colNum : NSInteger,rowSpacing : CGFloat,colSpacing : CGFloat,sectionInset : UIEdgeInsets) {
        self.init()
        self.col_num = colNum
        self.row_spacing = rowSpacing
        self.col_spacing = colSpacing
        self.section_inset = sectionInset

    }
/*重写prepare*/
    override func prepare() {
        super.prepare()
        for i in 0...self.col_num - 1{
            self.max_y_dict[i as NSNumber] = self.section_inset.top as NSNumber
            
        }
        
        let item_count : NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        self.attributes_array.removeAll()
        
        for i in 0...item_count - 1{
            let attributs : UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: IndexPath.init(row: i, section: 0))
            self.attributes_array.append(attributs)

        }

    }
    override func layoutAttributesForItem(at indexPath : IndexPath) -> UICollectionViewLayoutAttributes {
        super.layoutAttributesForItem(at: indexPath)
        let attributs : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        
        let width : CGFloat = (self.collectionView?.frame.size.width)!
        
        let cell_width : CGFloat =  (width - self.section_inset.left - self.section_inset.right - CGFloat((self.col_num - 1)) * CGFloat(self.col_spacing)) / CGFloat(self.col_num)
        
        let cell_height : CGFloat =  (delgate?.collectionView(heightOfCell: self, width: cell_width, At: indexPath))!
        var  min_index : NSNumber = 0
        for (key,value) in self.max_y_dict{
            if (self.max_y_dict[min_index]?.floatValue)! > value.floatValue{
                
                min_index = key

            }
            
        }
        let  cell_x : CGFloat = self.section_inset.left + (CGFloat(self.col_spacing) + cell_width) * CGFloat(truncating: min_index)
        
        let cell_y : CGFloat = CGFloat(truncating: self.max_y_dict[min_index]!) + self.row_spacing
        
        attributs.frame = CGRect.init(x: cell_x, y: cell_y, width: cell_width, height: cell_height)
        
        
        self.max_y_dict[min_index] = attributs.frame.maxY as NSNumber

        return attributs
        
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        return self.attributes_array
    }
    
    
}
