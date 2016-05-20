//
//  ViewController.m
//  tablevewi
//
//  Created by ervin on 16/4/21.
//  Copyright © 2016年 ervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView *table;
    UITableView *one;
    UITableView *two;
    UIScrollView *scroll;
    UIImageView *header;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height);
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    one = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    one.delegate = self;
    one.dataSource = self;
    
    two = [[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    two.backgroundColor = [UIColor blueColor];
    two.delegate = self;
    two.dataSource = self;
    header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    header.backgroundColor = [UIColor redColor];
    header.image = [UIImage imageNamed:@"banner"];
    [scroll addSubview:one];
    [scroll addSubview:two];
    [self.view addSubview:scroll];
    [self.view addSubview:header];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == one) {
        CGFloat offset = one.contentOffset.y;
        CGFloat headerY;
        if (offset > 0) {
            headerY = offset;
            header.frame = CGRectMake(0, -headerY, [UIScreen mainScreen].bounds.size.width, 200);
        }else{
            headerY = offset;
            header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200-headerY);
            header.contentMode = UIViewContentModeScaleAspectFill;
        }
        if (two.contentOffset.y > 200 && one.contentOffset.y > 200) {
            return;
        }
        two.contentOffset = CGPointMake(two.contentOffset.x, headerY);
    }
    if (scrollView == two) {
        CGFloat offset = two.contentOffset.y;
        CGFloat headerY;
        if (offset > 0) {
            headerY = offset;
            header.frame = CGRectMake(0, -headerY, [UIScreen mainScreen].bounds.size.width, 200);
        }else{
            headerY = offset;
            header.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200-headerY);
            header.contentMode = UIViewContentModeScaleAspectFill;
        }
        
        if (one.contentOffset.y > 200 && two.contentOffset.y > 200) {
            return;
        }
        one.contentOffset = CGPointMake(one.contentOffset.x, headerY);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (tableView == two) {
        if (indexPath.row %2 == 1 ) {
            cell.contentView.backgroundColor = [UIColor orangeColor];
        }else{
        cell.contentView.backgroundColor = [UIColor blueColor];
        }
    }
    if (tableView == one) {
        if (indexPath.row %2 == 1 ) {
            cell.contentView.backgroundColor = [UIColor blackColor];
        }else{
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 99;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return  250;
    }else{
        return 60;
    }
}
@end
