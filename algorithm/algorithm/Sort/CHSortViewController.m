//
//  CHSortViewController.m
//  algorithm
//
//  Created by chenyuliang on 2019/4/23.
//  Copyright © 2019 didi. All rights reserved.
//

#import "CHSortViewController.h"

@interface CHSortViewController ()

@property (nonatomic, strong) UILabel *unsortLabel;
@property (nonatomic, strong) UILabel *sortedLabel;

@property (nonatomic, copy) NSArray *unsortArray;
@property (nonatomic, strong) NSMutableArray *sortedArray;

@property (nonatomic, strong) UIButton *bubbleBtn;

@end

@implementation CHSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _unsortArray = @[@3,@2,@1,@5,@8,@23,@45,@99,@12,@4,@100,@66,@3,@89,@103];
    _sortedArray = [NSMutableArray new];
    [self.view addSubview:self.unsortLabel];
    [self.view addSubview:self.sortedLabel];
    [self.view addSubview:self.bubbleBtn];
     @weakify(self);
    [RACObserve(self, sortedArray) subscribeNext:^(id x) {
        @strongify(self);
        __block NSMutableString *result = [NSMutableString new];
        [self.sortedArray.rac_sequence.signal subscribeNext:^(id x) {
            [result appendString:[NSString stringWithFormat:@"%@  ",x]];
        } completed:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sortedLabel.text = result;
            });
        }];
    }];
    // Do any additional setup after loading the view.
}

- (UILabel *)unsortLabel
{
    if (!_unsortLabel) {
        _unsortLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
        _unsortLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        _unsortLabel.textColor = [UIColor blackColor];
    }
    return _unsortLabel;
}

- (UILabel *)sortedLabel
{
    if (!_sortedLabel) {
        _sortedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
        _sortedLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        _sortedLabel.textColor = [UIColor blackColor];
        _sortedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortedLabel;
}

- (UIButton *)bubbleBtn
{
    if (!_bubbleBtn) {
        _bubbleBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 350, 80, 60)];
        _bubbleBtn.backgroundColor = [UIColor whiteColor];
        [_bubbleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_bubbleBtn setTitle:@"冒泡排序" forState:UIControlStateNormal];
        @weakify(self);
        [[_bubbleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self bubbleSort];
        }];
    }
    return _bubbleBtn;
}


- (void)bubbleSort
{
    NSMutableArray *sorted = _unsortArray.mutableCopy;
    
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
    self.sortedArray = sorted;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
