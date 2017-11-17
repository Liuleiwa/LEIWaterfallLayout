#### 瀑布流布局
#### 使用
将LEIWaterfallLayout文件拖入项目#import "LEIWaterfallLayout"
```
        /*colNum:列数  rowSpacing：行距  colSpacing列距  */
        let waterLayout : LEIWaterfallLayout = LEIWaterfallLayout.init(colNum: 2, rowSpacing: 10, colSpacing: 10, sectionInset: UIEdgeInsetsMake(10, 10, 10, 10))
        /*设置代理*/
        waterLayout.delgate = self
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: waterLayout);
```

```
    /*实现代理方法返回每个cell的高度*/
    func collectionView(heightOfCell layout: LEIWaterfallLayout, width: CGFloat, At indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 3 ? 210 : 280

    }
```
