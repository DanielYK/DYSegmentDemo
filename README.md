
DYSegmentDemo
=
喜欢的朋友可以下载下来，如果代码对你有所帮助，还请给个Star，非常感谢你的支持！
= 
 * 选择滑动控件
 * 实现功能：滑动切换，点击切换，字体颜色渐变，标题选中和未选中时的逐渐形变。
 
 * 效果图
 
  ![image](https://github.com/DanielYK/DYSegmentDemo/blob/master/segmentView.gif)


 * 对应文件
 * DYSegmentView : 自定义滑动控件实现类
 
 * 具体使用
<pre><code>
-(DYSegmentView *)dySegment{
    if (!_dySegment) {
        _dySegment = [[DYSegmentView alloc]initWithFrame:CGRectMake(ScreenWidth/2-120, 25, 240, 44)];
        _dySegment.delegate         = self;
        _dySegment.backgroundColor  = [UIColor clearColor];
        _dySegment.titleNormalColor = UIColorFromRGB(0xffffff, 0.5);
        _dySegment.titleSelectColor = UIColorFromRGB(0xffffff, 0.9);
        _dySegment.titleFont        = [UIFont systemFontOfSize:15];
        _dySegment.titleArray       = @[@"在线",@"附近"];
    }
    return _dySegment;
}
    self.navigationItem.titleView = self.dySegment;
</code></pre>

* 实现相对应的代理方法 <DYSegmentDelegate,UIScrollViewDelegate>
<pre><code>
#pragma mark - UIScrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_dySegment dyDidScrollChangeTheTitleColorWithContentOfSet:scrollView.contentOffset.x];
}
#pragma mark - DYSegmentDelegate
-(void)dySegment:(DYSegmentView *)segment didSelectIndex:(NSInteger)index{
    NSString *notiStr;
    if (index == 1) {
        notiStr = @"1";
    }else{
        notiStr = @"2";
    }
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*(index-1), 0);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MainViewScrollDidScroll" object:notiStr];
}
</code></pre>

 - 使用过程中有问题请加QQ或发邮件:584379066 备注：Git SegmentView

