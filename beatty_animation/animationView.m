//
//  animationView.m
//  beatty_animation
//
//  Created by Xiaohe Hu on 7/20/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

#import "animationView.h"

static float    smallGridSize = 117.0;
static float    largeGridSize = 360.0;

@interface animationView() {
    
    BOOL            expanded;
    
    int             currentIndex;
    
    UIView          *uiv_gridContainer;
    UIView          *uiv_grid0;
    UIView          *uiv_grid1;
    UIView          *uiv_grid2;
    UIView          *uiv_grid3;
    UIView          *uiv_grid4;
    UIView          *uiv_grid5;
    UIView          *uiv_grid6;
    UIView          *uiv_grid7;
    UIView          *uiv_grid8;
    UIView          *uiv_textContent;
    UIView          *uiv_indicator;
    UIButton        *uib_arrow;
    NSArray         *arr_grids;
    NSArray         *arr_indicator;
}

@end

@implementation animationView

#pragma mark - View's life cycle
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0,0,1024,768)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createGridArray];
        [self setupHierarchy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self createGridArray];
        [self setupHierarchy];
    }
    return self;
}

- (void)didMoveToSuperview {
    [self performSelector:@selector(loadInAnimaiton) withObject:nil afterDelay:1.0];
}

#pragma mark - Init all UI elements
- (void)createGridArray {
    // Init all grid views
    uiv_grid0 = [UIView new];
    uiv_grid1 = [UIView new];
    uiv_grid2 = [UIView new];
    uiv_grid3 = [UIView new];
    uiv_grid4 = [UIView new];
    uiv_grid5 = [UIView new];
    uiv_grid6 = [UIView new];
    uiv_grid7 = [UIView new];
    uiv_grid8 = [UIView new];
    
    // Add grid views to array
    arr_grids = @[uiv_grid0,
                  uiv_grid1,
                  uiv_grid2,
                  uiv_grid3,
                  uiv_grid4,
                  uiv_grid5,
                  uiv_grid6,
                  uiv_grid7,
                  uiv_grid8];
    
    // Set tag to grid views
    for (int i = 0; i < arr_grids.count; i++) {
        [arr_grids[i] setTag: i];
    }
}

- (void)setupHierarchy {
    uiv_gridContainer = [[UIView alloc] initWithFrame:CGRectMake(22, 204, largeGridSize, largeGridSize)];
    uiv_gridContainer.backgroundColor = [UIColor greenColor];
    uiv_gridContainer.clipsToBounds = YES;
    [self addSubview: uiv_gridContainer];
    
    float gridTopGap = 2.0;
    float gridAndGap = 120;
    
    for (UIView *grid in arr_grids) {
        int x_position = (int)grid.tag%3;
        int y_position = (int)grid.tag/3;
        grid.frame = CGRectMake(x_position * gridAndGap, y_position * gridAndGap+gridTopGap, smallGridSize, smallGridSize);
        grid.backgroundColor = [UIColor colorWithRed:30.0*grid.tag/255.0 green:18.0*grid.tag/255.0 blue:20.0*grid.tag/255.0 alpha:1.0];
        [uiv_gridContainer addSubview: grid];
        grid.alpha = 0.0;
    }
    
    float expandButtonSize = 40;
    float expandButtonX = 342;
    float expandButtonY = 364;
    uib_arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_arrow.frame = CGRectMake(expandButtonX, expandButtonY, expandButtonSize, expandButtonSize);
    uib_arrow.backgroundColor = [UIColor blueColor];
    [self insertSubview:uib_arrow belowSubview:uiv_gridContainer];
    [uib_arrow addTarget:self action:@selector(tapArrowButtonOpen:) forControlEvents:UIControlEventTouchUpInside];
    
    uiv_textContent = [[UIView alloc] initWithFrame:CGRectMake(380, 100, 271, 167)];
    uiv_textContent.backgroundColor = [UIColor blackColor];
    uiv_textContent.alpha = 0.8;
    [uiv_gridContainer addSubview: uiv_textContent];
    
    [self createIndicatorView];
}

- (void)createIndicatorView {
    uiv_indicator = [[UIView alloc] initWithFrame:CGRectMake(331, 16, 17, 17)];
    uiv_indicator.backgroundColor = [UIColor whiteColor];
    [uiv_gridContainer addSubview: uiv_indicator];
    
    UIColor *uic_normal = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0];
    
    UIView *uiv_0 = [UIView new];
    UIView *uiv_1 = [UIView new];
    UIView *uiv_2 = [UIView new];
    UIView *uiv_3 = [UIView new];
    UIView *uiv_4 = [UIView new];
    UIView *uiv_5 = [UIView new];
    UIView *uiv_6 = [UIView new];
    UIView *uiv_7 = [UIView new];
    UIView *uiv_8 = [UIView new];

    arr_indicator = @[uiv_0,
                      uiv_1,
                      uiv_2,
                      uiv_3,
                      uiv_4,
                      uiv_5,
                      uiv_6,
                      uiv_7,
                      uiv_8];

    for (int i = 0; i < arr_indicator.count; i++) {
        [arr_indicator[i] setTag:i];
    }
    
    for (UIView *indicator in arr_indicator) {
        int x_position = (int)indicator.tag%3;
        int y_position = (int)indicator.tag/3;
        indicator.frame = CGRectMake(x_position * 6, y_position * 6, 5, 5);
        indicator.backgroundColor = uic_normal;
        [uiv_indicator addSubview: indicator];
    }
}

- (void)resetIndicatorColor {

}

- (void)updateIndicatorColor {
    
    UIColor *uic_normal = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0];
    UIColor *uic_selected = [UIColor colorWithRed:216.0/255.0 green:35.0/255.0 blue:42.0/255.0 alpha:1.0];
    
    for (UIView *indicator in arr_indicator) {
        indicator.backgroundColor = uic_normal;
        if (indicator.tag == currentIndex) {
            indicator.backgroundColor = uic_selected;
        }
    }
}

- (void)loadInAnimaiton {
    for (UIView *grid in arr_grids) {
        int x_position = (int)grid.tag%3;
        int y_position = (int)grid.tag/3;
        float animation_time = 0.6-0.1*x_position-0.1*y_position;
        [UIView animateWithDuration:animation_time delay:animation_time/2 options:0 animations:^(void){
            grid.alpha = 1.0;
        } completion:^(BOOL finished){
            UITapGestureRecognizer *tapOnGrid = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandGrid:)];
            grid.userInteractionEnabled = YES;
            [grid addGestureRecognizer: tapOnGrid];
        }];
    }
}

- (void)expandGrid:(UIGestureRecognizer *)gesture {
    
    [arr_indicator[[gesture.view tag]] setBackgroundColor:[UIColor colorWithRed:216.0/255.0 green:35.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    currentIndex = (int)[gesture.view tag];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        [gesture view].frame = uiv_gridContainer.bounds;
        uib_arrow.frame = CGRectMake(402, 364, 40, 40);
        
        for (UIView *grid in arr_grids) {
            if ([grid isEqual: gesture.view]) {
                continue;
            } else {
                grid.alpha = 0.0;
            }
        }
        
    } completion:^(BOOL finished){
        [self bringSubviewToFront:uib_arrow];
        [UIView animateWithDuration:0.3 animations:^(void){
            uib_arrow.frame = CGRectMake(362, 364, 40, 40);
        }];
        
        for (UIView *grib in arr_grids) {
            for (UIGestureRecognizer *gesture in grib.gestureRecognizers) {
                [grib removeGestureRecognizer: gesture];
            }
            
            UISwipeGestureRecognizer *swipeLeftOnGrib = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGrib:)];
            swipeLeftOnGrib.direction = UISwipeGestureRecognizerDirectionLeft;
            [grib addGestureRecognizer: swipeLeftOnGrib];
            
            UISwipeGestureRecognizer *swipeRightOnGrib = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGrib:)];
            swipeRightOnGrib.direction = UISwipeGestureRecognizerDirectionRight;
            [grib addGestureRecognizer: swipeRightOnGrib];
        }
    }];
}

- (void)swipeLeftGrib:(UIGestureRecognizer *)gesture {
//    NSLog(@"\n\n Swipe to left\n\n");
    if (expanded) {
        [self tapArrowButtonClose:nil];
        [self performSelector:@selector(loadNextGrid) withObject:nil afterDelay:0.5];
        return;
    } else {
        [self loadNextGrid];
    }
}

- (void)swipeRightGrib:(UIGestureRecognizer *)gesture {
//    NSLog(@"\n\n Swipe to right \n\n");
    if (expanded) {
        [self tapArrowButtonClose:nil];
        [self performSelector:@selector(loadPreGrid) withObject:nil afterDelay:0.5];
        return;
    } else {
        [self loadPreGrid];
    }
}

- (void)loadNextGrid {
    int nextIndex = 0;
    if (currentIndex != 8) {
        nextIndex = currentIndex + 1;
    }
    UIView *nextView = arr_grids[nextIndex];
    UIView *currView = arr_grids[currentIndex];
    nextView.frame = uiv_gridContainer.bounds;
    nextView.transform = CGAffineTransformMakeTranslation(largeGridSize, 0);
    nextView.alpha = 1.0;
    [UIView animateWithDuration:0.33 animations:^(void){
        nextView.transform = CGAffineTransformIdentity;
        currView.transform = CGAffineTransformMakeTranslation(-largeGridSize, 0.0);
    } completion:^(BOOL finished){
        currView.transform = CGAffineTransformIdentity;
        currView.alpha = 0.0;
        currentIndex = nextIndex;
        [self updateIndicatorColor];
    }];
}

- (void)loadPreGrid {
    int preIndex = 8;
    if (currentIndex != 0) {
        preIndex = currentIndex - 1;
    }
    UIView *preView = arr_grids[preIndex];
    UIView *currView = arr_grids[currentIndex];
    preView.frame = uiv_gridContainer.bounds;
    preView.transform = CGAffineTransformMakeTranslation(-largeGridSize, 0);
    preView.alpha = 1.0;
    [UIView animateWithDuration:0.33 animations:^(void){
        preView.transform = CGAffineTransformIdentity;
        currView.transform = CGAffineTransformMakeTranslation(largeGridSize, 0.0);
    } completion:^(BOOL finished){
        currView.transform = CGAffineTransformIdentity;
        currView.alpha = 0.0;
        currentIndex = preIndex;
        [self updateIndicatorColor];
    }];
}


- (void)tapArrowButtonOpen:(id)sender {
    
    expanded = YES;
    
    CGAffineTransform move = CGAffineTransformMakeTranslation(250, 0.0);
    CGAffineTransform rotation = CGAffineTransformRotate(move, M_PI_4);
    
    [UIView animateWithDuration:0.5 animations:^(void){
        uiv_gridContainer.frame = CGRectMake(uiv_gridContainer.frame.origin.x, uiv_gridContainer.frame.origin.y, 610, uiv_gridContainer.frame.size.height);
        uib_arrow.transform = rotation;
        uiv_textContent.alpha = 1.0;
        uiv_textContent.transform = CGAffineTransformMakeTranslation(-42, 0.0);
        uiv_indicator.transform = CGAffineTransformMakeTranslation(250.0, 0.0);
    } completion:^(BOOL finished){
        [uib_arrow removeTarget:self action:@selector(tapArrowButtonOpen:) forControlEvents:UIControlEventAllEvents];
        [uib_arrow addTarget:self action:@selector(tapArrowButtonClose:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)tapArrowButtonClose:(id)sender {
    
    expanded = NO;
    
    [UIView animateWithDuration:0.5 animations:^(void){
        uiv_gridContainer.frame = CGRectMake(uiv_gridContainer.frame.origin.x, uiv_gridContainer.frame.origin.y, 360, uiv_gridContainer.frame.size.height);
        uib_arrow.transform = CGAffineTransformIdentity;
        uiv_textContent.alpha = 0.8;
        uiv_textContent.transform = CGAffineTransformIdentity;
        uiv_indicator.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        [uib_arrow removeTarget:self action:@selector(tapArrowButtonClose:) forControlEvents:UIControlEventAllEvents];
        [uib_arrow addTarget:self action:@selector(tapArrowButtonOpen:) forControlEvents:UIControlEventTouchUpInside];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
