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
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *insertBtn;

@property (nonatomic, strong) UIButton *shellBtn;
@property (nonatomic, strong) UIButton *heapBtn;
@property (nonatomic, strong) UIButton *quickBtn;

@property (nonatomic, strong) UIButton *c_qsortBtn;

@end

@implementation CHSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _unsortArray = @[@3,@2,@1,@5,@8,@23,@45,@99,@12,@4,@100,@66,@3,@89,@103];
    _sortedArray = [NSMutableArray new];
    [self.view addSubview:self.unsortLabel];
    [self.view addSubview:self.sortedLabel];
    [self.view addSubview:self.bubbleBtn];
    [self.view addSubview:self.selectBtn];
    [self.view addSubview:self.insertBtn];
    [self.view addSubview:self.shellBtn];
    [self.view addSubview:self.heapBtn];
    [self.view addSubview:self.quickBtn];
    [self.view addSubview:self.c_qsortBtn];
    
     @weakify(self);
    [RACObserve(self, sortedArray) subscribeNext:^(id x) {
        @strongify(self);
        NSMutableString *result = [NSMutableString new];
        result = [self.sortedArray.rac_sequence foldLeftWithStart:@"" reduce:^id(id accumulator, id value) {
            return  [accumulator stringByAppendingString:[NSString stringWithFormat:@"%@ ",value]];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sortedLabel.text = result;
        });
    }];
    
    self.unsortLabel.text = [_unsortArray.rac_sequence foldLeftWithStart:@"" reduce:^id(id accumulator, id value) {
        return  [accumulator stringByAppendingString:[NSString stringWithFormat:@"%@ ",value]];
    }];
    
    // Do any additional setup after loading the view.
}

- (UILabel *)unsortLabel
{
    if (!_unsortLabel) {
        _unsortLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
        _unsortLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        _unsortLabel.textColor = [UIColor blackColor];
        _unsortLabel.textAlignment = NSTextAlignmentCenter;
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

#pragma mark - 冒泡排序

- (UIButton *)bubbleBtn
{
    if (!_bubbleBtn) {
        _bubbleBtn = [self createBtnWithTitle:@"冒泡排序" frame:CGRectMake(40, 350, 80, 60) sel:@selector(bubbleSort)];
    }
    return _bubbleBtn;
}


- (void)bubbleSort
{
    NSMutableArray *sorted = _unsortArray.mutableCopy;
    
    NSUInteger count = sorted.count;
    
    for (NSUInteger i = 1; i< count; i++) {
        
        bool flag = true;
        
        for (NSUInteger j = 0; j< count - i; j++) {
            
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

#pragma mark - 选择排序

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [self createBtnWithTitle:@"选择排序" frame:CGRectMake(150, 350, 80, 60) sel:@selector(selectSort)];
    }
    return _selectBtn;
}

- (void)selectSort
{
    NSMutableArray *sorted = _unsortArray.mutableCopy;
    
    NSUInteger count = sorted.count;
    
    for (NSUInteger i = 0; i< count; i++) {
        
        NSUInteger min = i;
        
        for (NSUInteger j = i + 1; j< count; j++) {
            
            if ([sorted[j] intValue] < [sorted[min] intValue]) {
                min = j;
            }
        }
        
        if (min != i) {
            NSNumber *temp = sorted[i];
            sorted[i] = sorted[min];
            sorted[min] = temp;
        }
        
    }
    self.sortedArray = sorted;
}

#pragma mark - 插入排序

- (UIButton *)insertBtn
{
    if (!_insertBtn) {
        _insertBtn = [self createBtnWithTitle:@"插入排序" frame:CGRectMake(260, 350, 80, 60) sel:@selector(insertSort)];
    }
    return _insertBtn;
}

- (void)insertSort
{
    NSMutableArray *sorted = _unsortArray.mutableCopy;
    
    NSUInteger count = sorted.count;
    
    for (NSUInteger i = 1; i< count; i++) {
        
        NSNumber *temp = sorted[i];
        
        NSUInteger j = i;
        while (j > 0 && [temp intValue] < [sorted[j - 1] intValue]) {
            sorted[j] = sorted[j - 1];
            j--;
        }
        
        if (j != i) {
            sorted[j] = temp;
        }
        
    }
    self.sortedArray = sorted;
}
#pragma mark - 希尔排序

- (UIButton *)shellBtn
{
    if (!_shellBtn) {
        _shellBtn = [self createBtnWithTitle:@"希尔排序" frame:CGRectMake(40, 430, 80, 60) sel:@selector(shellSort)];
    }
    return _shellBtn;
}

- (void)shellSort
{
    NSMutableArray *sorted = _unsortArray.mutableCopy;
    
    NSUInteger count = sorted.count;
    
    NSUInteger gap = 1;
    while (gap < count) {
        gap = gap * 3  + 1;
    }
    
    while (gap > 0) {
        [self insertSortWithArray:sorted gap:gap];
        gap = gap/3;
    }
    self.sortedArray = sorted;
}

- (void)insertSortWithArray:(NSMutableArray *)sorted
                        gap:(NSUInteger )gap
{
    NSUInteger count = sorted.count;
    for (NSUInteger i = gap; i< count; i+= gap) {
        
        NSNumber *temp = sorted[i];
        
        NSUInteger j = i;
        while (j > 0 && [temp intValue] < [sorted[j - gap] intValue]) {
            sorted[j] = sorted[j - gap];
            j = j - gap;
        }
        
        if (j != i) {
            sorted[j] = temp;
        }
        
    }
}

#pragma mark - 堆排序

- (UIButton *)heapBtn
{
    if (!_heapBtn) {
        _heapBtn = [self createBtnWithTitle:@"堆排序" frame:CGRectMake(150, 430, 80, 60) sel:@selector(heapSort)];
    }
    return _heapBtn;
}

- (void)heapSort
{
    
}

#pragma mark - 快速排序

- (UIButton *)quickBtn
{
    if (!_quickBtn) {
        _quickBtn = [self createBtnWithTitle:@"快速排序" frame:CGRectMake(260, 430, 80, 60) sel:@selector(quickSort)];
    }
    return _quickBtn;
}

- (void)quickSort
{
    
}


#pragma mark - C++ 排序实现

- (UIButton *)c_qsortBtn
{
    if (!_c_qsortBtn) {
        _c_qsortBtn = [self createBtnWithTitle:@"C++排序" frame:CGRectMake(40, 510, 80, 60) sel:@selector(c_qsort)];
    }
    return _c_qsortBtn;
}

- (void)c_qsort
{
    
}



- (UIButton *)createBtnWithTitle:(NSString *)title
                           frame:(CGRect )frame
                             sel:(SEL)aSel
{
    _bubbleBtn = [[UIButton alloc] initWithFrame:frame];
    _bubbleBtn.backgroundColor = [UIColor whiteColor];
    [_bubbleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bubbleBtn setTitle:title forState:UIControlStateNormal];
    @weakify(self);
    [[_bubbleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self performSelector:aSel];
    }];
    return _bubbleBtn;
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
