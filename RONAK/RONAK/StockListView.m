//
//  StockListView.m
//  RONAK
//
//  Created by Gaian on 1/17/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "StockListView.h"

@implementation StockListView{
    
    IBOutlet UIScrollView *containerView;
    CGFloat vw_Width,vw_Height;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self=[[NSBundle mainBundle]loadNibNamed:@"StockListView" owner:self options:nil][0];
        vw_Width=frame.size.width;
        vw_Height=frame.size.height;
        self.frame=frame;
        self.layer.cornerRadius=10.0f;
        self.clipsToBounds=YES;
    }
    return self;
}
-(void)showStockfromStockMaster:(NSArray*)st{
    
    int ax=0,ay=10,bx=vw_Width/2,by=10;
    for (StockDetails *std in st) {
        UILabel *warehouseName=[[UILabel alloc]initWithFrame:CGRectMake(ax, ay, vw_Width/2-5, 30)];
        [containerView addSubview:warehouseName];
        warehouseName.text=std.warehouse_Name_s;
        warehouseName.backgroundColor=[UIColor whiteColor];
        UILabel *stocckCount=[[UILabel alloc]initWithFrame:CGRectMake(bx+5, by, vw_Width/2-5, 30)];
        [containerView addSubview:stocckCount];
        stocckCount.text=[NSString stringWithFormat:@"%d",std.stock__s];
        stocckCount.backgroundColor=[UIColor whiteColor];
        stocckCount.textAlignment=NSTextAlignmentCenter;
        ay+=40;
        by+=40;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
