//
//  ViewController.m
//  algorithm
//
//  Created by chenyuliang on 2019/4/23.
//  Copyright © 2019 didi. All rights reserved.
//

#import "ViewController.h"
#import "CHSortViewController.h"
#import "LeetCodeViewController.h"

@interface algorithmCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) dispatch_block_t clickBlock;

@end

@implementation algorithmCellModel
@end


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *cellArray;

@end

static const NSString *cellIdentifier = @"algorithmCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Remember Algorithm"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                                    NSForegroundColorAttributeName:[UIColor blackColor]};
    [self GenerateDataSource];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"algorithmCell"];
    algorithmCellModel *cellModel = _cellArray[indexPath.row];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"algorithmCell"];
        cell.textLabel.text = cellModel.title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    algorithmCellModel *cellModel = _cellArray[indexPath.row];
    cellModel.clickBlock();
}


- (void)GenerateDataSource
{
    NSMutableArray *dataArray = [NSMutableArray new];
    
    algorithmCellModel *sortModel = [algorithmCellModel new];
    sortModel.title = @"Sort";
    sortModel.clickBlock = ^{
        CHSortViewController *sortVC = [[CHSortViewController alloc] init];
        [self.navigationController pushViewController:sortVC animated:YES];
    };
    
    algorithmCellModel *leetCodeModel = [algorithmCellModel new];
    leetCodeModel.title = @"LeetCode Solution";
    leetCodeModel.clickBlock = ^{
        LeetCodeViewController *leetCodeVC = [[LeetCodeViewController alloc] init];
        [self.navigationController pushViewController:leetCodeVC animated:YES];
    };
    
    [dataArray addObject:sortModel];
    
    [dataArray addObject:leetCodeModel];
    
    _cellArray = dataArray.copy;
}


@end
