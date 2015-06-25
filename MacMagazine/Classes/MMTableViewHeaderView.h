//
//  MMTableViewHeaderView.h
//  MacMagazine
//
//  Created by Fernando Saragoca on 6/21/15.
//  Copyright (c) 2015 made@sampa. All rights reserved.
//

@import UIKit;
#import "MMLabel.h"

@interface MMTableViewHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) MMLabel *titleLabel;
@property (strong, nonatomic) UIView *topSeparatorView;
@property (strong, nonatomic) UIView *bottomSeparatorView;

+ (NSString *)identifier;
+ (CGFloat)height;

@end
