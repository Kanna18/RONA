//
//  Draft3.m
//  CustomAlert
//
//  Created by TTPLCOMAC1 on 28/08/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "CollectionPopUp.h"
#import "DefaultFiltersViewController.h"
@implementation CollectionPopUp

-(instancetype)initWithFrame:(CGRect)frame witTitle:(NSString*)title withSuperView:(OrderSummaryVC*)supVw
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle]loadNibNamed:@"CollectionPopUp" owner:self options:nil][0];
        _osVC=supVw;
        _titleLabel.text=title;
    }
    
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle]loadNibNamed:@"CollectionPopUp" owner:self options:nil][0];
    }
    
    
    return self;
}

-(IBAction)noClick:(id)sender
{
    [self removeFromSuperview];
    if(_osVC){
    _osVC.draftBtn.selected=NO;
    _osVC.deliveryBtn.selected=NO;
    }
}
-(IBAction)yesClick:(id)sender
{
    [self removeFromSuperview];
    if(_osVC){
    _osVC.draftBtn.selected=NO;
    _osVC.deliveryBtn.selected=NO;
    }
    if([_titleLabel.text isEqualToString:@"Are you sure you want to cancel the order?"])
    {
        NSArray *arr=_osVC.navigationController.viewControllers;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isKindOfClass:[DefaultFiltersViewController class]])
            {
                [_osVC.navigationController popToViewController:(DefaultFiltersViewController*)obj animated:YES];
                return ;
                
            }
        }];
        for (CustomerDataModel *cst in selectedCustomersList)
        {
            [cst.defaultsCustomer.itemsCount removeAllObjects];
            cst.defaultsCustomer.discount=@"";
        }
        if(ronakGlobal.currentDraftRecord){
            [self checkInternetConnectivityandDeleteDraft];
        }
    }
}
-(void)checkInternetConnectivityandDeleteDraft{
    
    Reachability *reachability= [Reachability reachabilityForInternetConnection];
    if([reachability isReachable]){
        [_osVC deleteDraft];
    }else{
        if(ronakGlobal.currentDraftRecord!=nil){//if Draft Rec is available;
            NSMutableArray *drfsArr=[[NSMutableArray alloc]initWithArray:defaultGet(deleteDraftOfflineArray)];
            [drfsArr addObject:ronakGlobal.currentDraftRecord];
            ronakGlobal.currentDraftRecord=nil;
            defaultSet(drfsArr, deleteDraftOfflineArray);
        }
    }
}
@end
