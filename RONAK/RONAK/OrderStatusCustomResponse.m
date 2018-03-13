//
//  OrderStatusCustomResponse.m
//  RONAK
//
//  Created by Gaian on 11/7/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusCustomResponse.h"

@implementation CustomRecord

-(instancetype)initWithDict:(id)dict withRecodeType:(TypeOfRecord*)rec
{
    self=[super init];
    if(self)
    {
        if(rec==INVOICE_Type)
        {
//            _tvData=[[NSMutableArray alloc]init];
            InvoiceRecords *invRec=dict;
            _typeOrder__c=invRec.Sale_Order__c;
            _typeId=invRec.Id;
            _typeName=invRec.Name;
            _typeDate__c=invRec.Invoice_Date__c;
            _type_No__c=invRec.Invoice_No__c;
            _type_Status__c=invRec.Invoice_Status__c;
            _typeSale_Order_No__c=invRec.Sale_Order_No__c;
        }
        else if(rec==DELIVERY_Type)
        {
            DeliveryRecords *invRec=dict;
            _typeOrder__c=invRec.Sale_Order__c;
            _typeId=invRec.Id;
            _typeName=invRec.Name;
            _typeDate__c=invRec.Delivery_Date__c;
            _type_No__c=invRec.Delivery_No__c;
            _type_Status__c=invRec.Delivery_Status__c;
            _typeSale_Order_No__c=invRec.Sale_Order_No__c;
        }
    }
    return self;
}

@end

@implementation OrderStatusCustomResponse

-(instancetype)initWithDict:(OrderStatsResponse*)dict;
{
    self=[super init];
    if(self)
    {
        _tvData=[[NSMutableArray alloc]init];
        _cdId=dict.Id;
        _Name=dict.Name;
        _CreatedDate=dict.CreatedDate;
        _Discount__c=dict.Discount__c;
        _Brand__c=dict.Brand__c;
        _Quantity__c=dict.Quantity__c;
        _Account__c=dict.Account__c;
        _Customer_Name__c=dict.Customer_Name__c;
        _HOD_Date__c=dict.HOD_Date__c;
        _MD_Date__c=dict.MD_Date__c;
        _Sale_Order_Date__c=dict.Sale_Order_Date__c;
        _Sale_Order_No__c=dict.Sale_Order_No__c;
        _Ship_to_Party__c=dict.Ship_to_Party__c;
        _Ship_To_Party_Nmae__c=dict.Ship_To_Party_Nmae__c;
        _Status__c=dict.Status__c;
        _Net_Amount__c=dict.Net_Amount__c;
        _Remarks__c=dict.Remarks__c;
        _RSM_Date__c=dict.RSM_Date__c;
        _SAP_Date__c=dict.SAP_Date__c;
        _Sale_Order_No_Created_Date__c=dict.Sale_Order_Date__c;
        _finalizedDate=[dict.CreatedDate substringToIndex:10];
        [self statusCodesOnCell];
    }
    return self;
}

-(void)statusCodesOnCell
{
    if(_CreatedDate)
    {
        [_tvData addObject:@"SR"];
    }
    if(_RSM_Date__c)
    {
        [_tvData addObject:@"RSM"];
    }
    if(_HOD_Date__c)
    {
        [_tvData addObject:@"HOD"];
    }
    if(_MD_Date__c)
    {
        [_tvData addObject:@"MD"];
    }
    if(_SAP_Date__c)
    {
        [_tvData addObject:@"SAP"];
    }
    if(_Sale_Order_Date__c)
    {
        [_tvData addObject:@"SO"];
    }
    _statusCode_Response=_tvData.lastObject;
}
-(instancetype)initWithDict:(OrderStatsResponse*)dict andRecord:(id)rec;
{
    self=[super init];
    if(self)
    {
        _tvData=[[NSMutableArray alloc]init];
        _cdId=dict.Id;
        _Name=dict.Name;
        _CreatedDate=dict.CreatedDate;
        _Discount__c=dict.Discount__c;
        _Brand__c=dict.Brand__c;
        _Quantity__c=dict.Quantity__c;
        _Account__c=dict.Account__c;
        _Customer_Name__c=dict.Customer_Name__c;
        _HOD_Date__c=dict.HOD_Date__c;
        _MD_Date__c=dict.MD_Date__c;
        _Sale_Order_Date__c=dict.Sale_Order_Date__c;
        _Sale_Order_No__c=dict.Sale_Order_No__c;
        _Ship_to_Party__c=dict.Ship_to_Party__c;
        _Ship_To_Party_Nmae__c=dict.Ship_To_Party_Nmae__c;
        _Status__c=dict.Status__c;
        _Net_Amount__c=dict.Net_Amount__c;
        _Remarks__c=dict.Remarks__c;
        _RSM_Date__c=dict.RSM_Date__c;
        _SAP_Date__c=dict.SAP_Date__c;
        _Sale_Order_No_Created_Date__c=dict.Sale_Order_Date__c;
        if([rec isKindOfClass:[InvoiceRecords class]])
        {
            _typeOfRec=INVOICE_Type;
            _record=[[CustomRecord alloc]initWithDict:rec withRecodeType:INVOICE_Type];
            InvoiceRecords *invRec=rec;
            _finalizedDate=invRec.Invoice_Date__c;
        }
        else if ([rec isKindOfClass:[DeliveryRecords class]])
        {
            _typeOfRec=DELIVERY_Type;
            _record=[[CustomRecord alloc]initWithDict:rec withRecodeType:DELIVERY_Type];
            DeliveryRecords *invRec=rec;
            _finalizedDate=invRec.Delivery_Date__c;
        }
        NSDateFormatter *df=[[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        _finalizedDateFormat=[df dateFromString: _finalizedDate];
        [self statusCodesOnCell];
        
    }
    return self;
}

@end
