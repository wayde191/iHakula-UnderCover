//
//  UCUserView.m
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCUserView.h"
#import "Player.h"

@implementation UCUserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setValues:(Player *)aplayer byIndex:(NSInteger)index {
    CGSize realSize = [aplayer.name sizeWithFont:_nameLabel.font];
    if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        _nameLabel.font = [UIFont systemFontOfSize:30];
        realSize = [aplayer.name sizeWithFont:_nameLabel.font];
        self.size = CGSizeMake(80, 50);
    }
    CGFloat dValue = realSize.width - _nameLabel.width;
    self.width += dValue;
    
    self.nameLabel.text = aplayer.name;
    self.indexLabel.text = [NSString stringWithFormat:@"%d", index];
    NSString *imageName = [NSString stringWithFormat:@"TrackColor_%d.png", index % 7 == 0 ? 7 : (index % 7)];
    self.colorImgView.image = ImageNamed(imageName);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
