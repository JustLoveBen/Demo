To fix some bugs about reloadData in collectionView.

1.
```
Invalid update: invalid number of items in section 0. The number of items contained in an existing section after the update (71) must be equal to the number of items contained in that section before the update (71), plus or minus the number of items inserted or deleted from that section (70 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out).
```

2.
```
Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'request for index path for global index 559864306 when there are only 11 items in the collection view'
```

以下对上面这两个bug的解决：

苹果官方文档对UICollectionView中reloadData方法的说明如下：
```
- (void)reloadData; // discard the dataSource and delegate data and requery as necessary

Call this method to reload all of the items in the collection view. This causes the collection view to discard any currently visible items and redisplay them. For efficiency, the collection view only displays those cells and supplementary views that are visible. If the collection data shrinks as a result of the reload, the collection view adjusts its scrolling offsets accordingly.

You should not call this method in the middle of animation blocks where items are being inserted or deleted. Insertions and deletions automatically cause the table’s data to be updated appropriately.
```

文档中表示reloadData方法cannot update table's data automatically。

#### 测试方法
在 https://github.com/nst/iOS-Runtime-Headers 上找到UICollectionView，会发现有一个UICollectionViewData的变量，这个变量用来管理CollectionView的数据。collectionViewData中有_numItems变量，可以通过获取这个变量的值判断CollectionView的data是否发生了变化。

#### 测试结果
在调用reloadData方法后，numItems的值未立刻改变（也许某个时刻会变化）；调用reloadSections:方法后，numItems的值立刻改变 (insertItemsAtIndexPaths:，insertSections:也会立刻改变)。

#### 分析
在collectionView中，执行insertItemsAtIndexPaths:方法时会对collectionViewData中的数据量进行校验，若校验结果无法匹配则会引起Assert，而reloadData方法不能立刻改变data，这就会有一定的概率造成校验失败。


校验失败一般的Crash Log为：
Invalid update: invalid number of items in section 0. The number of items contained in an existing section after the update (71) must be equal to the number of items contained in that section before the update (71), plus or minus the number of items inserted or deleted from that section (70 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out).

有时也会表现为：
Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'request for index path for global index 559864306 when there are only 11 items in the collection view'
这里的global index也是UICollectionViewData的属性：

```
NSMutableIndexSet *_globalIndexesOfItemsAwaitingValidation;
id *_globalItems;

- (int)globalIndexForItemAtIndexPath:(id)arg1;
- (id)indexPathForItemAtGlobalIndex:(int)arg1;
```
在这里可以看出global index和index path之间的是有映射关系的。可能reloadData引起的data不能立刻改变的错误，会对collectionViewData中indexPath的值造成影响，进而通过- (int)globalIndexForItemAtIndexPath:(id)arg1;获取到的global index的值发生了错误。

在测试中，将reloadData去掉后，改为reloadSections:或insertItemsAtIndexPaths:、insertSections:后，未发现以上错误。
＊在某些数量变化不频繁的collectionView中可以使用reloadData，以使用reloadData提供的部分刷新的优化能力。
