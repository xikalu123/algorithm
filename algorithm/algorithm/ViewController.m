//
//  ViewController.m
//  algorithm
//
//  Created by chenyuliang on 2019/4/23.
//  Copyright © 2019 didi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

const static NSString *cellIdentifier = @"algorithmCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *unsortArray = @[@3,@2,@1,@5,@8,@23,@45,@99,@12,@4,@100];
    
    NSArray *sortedArray = [self bubble:unsortArray];

    for (NSNumber *item in sortedArray) {
        NSLog(@"ss=====%@",item);
    }
    
}

- (NSArray *)bubble:(NSArray *)unsortArray
{
    NSMutableArray *sorted = unsortArray.mutableCopy;
    
    NSUInteger count = sorted.count;
    
    for (NSUInteger i = 0; i< count; i++) {
        
        bool flag = true;
        
        for (NSUInteger j = 0; j< count - i - 1; j++) {
            
            if ([sorted[j] intValue] > [sorted[j+1] intValue]) {
                NSNumber *temp = sorted[j+1];
                sorted[j+1] = sorted[j];
                sorted[j] = temp;
                flag = false;
            }
        }
        if (flag) {
            break ;
        }
        
    }
    
    return sorted.copy;
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
