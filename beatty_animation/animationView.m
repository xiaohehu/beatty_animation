//
//  animationView.m
//  beatty_animation
//
//  Created by Xiaohe Hu on 7/20/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

#import "animationView.h"

@interface animationView() {
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
    UIButton        *uib_arrow;
    NSArray         *arr_grids;
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
    uiv_gridContainer = [[UIView alloc] initWithFrame:CGRectMake(22, 204, 360.0, 360.0)];
    uiv_gridContainer.backgroundColor = [UIColor greenColor];
    uiv_gridContainer.clipsToBounds = YES;
    [self addSubview: uiv_gridContainer];
    
    for (UIView *grid in arr_grids) {
        int x_position = grid.tag%3;
        int y_position = (int)grid.tag/3;
        grid.frame = CGRectMake(x_position*120, y_position*120+2, 117, 117);
        grid.backgroundColor = [UIColor redColor];
        [uiv_gridContainer addSubview: grid];
        grid.alpha = 0.0;
    }
    
    uib_arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_arrow.frame = CGRectMake(342, 364, 40, 40);
    uib_arrow.backgroundColor = [UIColor blueColor];
    [self insertSubview:uib_arrow belowSubview:uiv_gridContainer];
    [uib_arrow addTarget:self action:@selector(tapArrowButtonOpen:) forControlEvents:UIControlEventTouchUpInside];
    
    uiv_textContent = [[UIView alloc] initWithFrame:CGRectMake(590, 100, 250, 160)];
    uiv_textContent.backgroundColor = [UIColor blackColor];
    uiv_textContent.alpha = 0.0;
    [uiv_gridContainer addSubview: uiv_textContent];
}

- (void)loadInAnimaiton {
    for (UIView *grid in arr_grids) {
        int x_position = grid.tag%3;
        int y_position =(int)grid.tag/3;
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
    [UIView animateWithDuration:0.5 animations:^(void){
        [gesture view].frame = uiv_gridContainer.bounds;
        uib_arrow.frame = CGRectMake(402, 364, 40, 40);
    } completion:^(BOOL finished){
//        [self insertSubview:uib_arrow aboveSubview:uiv_gridContainer];
        [self bringSubviewToFront:uib_arrow];
        [UIView animateWithDuration:0.3 animations:^(void){
            uib_arrow.frame = CGRectMake(362, 364, 40, 40);
        }];
    }];
}

- (void)tapArrowButtonOpen:(id)sender {
    CGAffineTransform move = CGAffineTransformMakeTranslation(250, 0.0);
    CGAffineTransform rotation = CGAffineTransformRotate(move, M_PI_4);
    
    [UIView animateWithDuration:0.5 animations:^(void){
        uiv_gridContainer.frame = CGRectMake(uiv_gridContainer.frame.origin.x, uiv_gridContainer.frame.origin.y, 610, uiv_gridContainer.frame.size.height);
        uib_arrow.transform = rotation;
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.1 animations:^(void){
            uiv_textContent.alpha = 1.0;
            uiv_textContent.transform = CGAffineTransformMakeTranslation(-230, 0.0);
        }];
        
        [uib_arrow removeTarget:self action:@selector(tapArrowButtonOpen:) forControlEvents:UIControlEventAllEvents];
        [uib_arrow addTarget:self action:@selector(tapArrowButtonClose:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)tapArrowButtonClose:(id)sender {
    [UIView animateWithDuration:0.5 animations:^(void){
        uiv_gridContainer.frame = CGRectMake(uiv_gridContainer.frame.origin.x, uiv_gridContainer.frame.origin.y, 360, uiv_gridContainer.frame.size.height);
        uib_arrow.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.1 animations:^(void){
            uiv_textContent.alpha = 0.0;
            uiv_textContent.transform = CGAffineTransformIdentity;
        }];
        
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
