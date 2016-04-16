先看看下面这两个crash log：

1.
```
Invalid update: invalid number of items in section 0. The number of items contained in an existing section after the update (71) must be equal to the number of items contained in that section before the update (71), plus or minus the number of items inserted or deleted from that section (70 inserted, 0 deleted) and plus or minus the number of items moved into or out of that section (0 moved in, 0 moved out).
```

2.

```
Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'request for index path for global index 559864306 when there are only 11 items in the collection view'
```

你在web上搜索后会发现有很多人建议(stackoverflow上有)：
```
若执行插入数据之前，collectionview中没有data，建议使用reloadData的方式刷新collectionview。
```

我很好奇为什么要这么做，就写了个小demo测试，但是测试的结果告诉我不用reloadData，用insertIndexPaths:也是可以的。
