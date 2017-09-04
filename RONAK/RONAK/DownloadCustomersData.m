//
//  DownloadCustomersData.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })
#define formatStr(strF) [NSString stringWithFormat:@"%@",strF]

#import "DownloadCustomersData.h"

@implementation DownloadCustomersData
{
    ServerAPIManager *serverAPI;
    NSURLSessionDataTask *sessionDatatask;
}

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

-(void)restServiceForCustomerList
{
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_customersList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self saveCSTDetailsAtoLocal:arr];
        
    }];
    
    [dataTask resume];
}
-(void)saveCSTDetailsAtoLocal:(NSArray*)arr
{
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext*  mYcontext=delegate.customerManagerObjectContext;
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *code=obj[@"Id"];
        NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([CustomerDetails class])];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId == %@",code];
        [fetch setPredicate:predicate];
        NSArray *arr=[mYcontext executeFetchRequest:fetch error:nil];
        if(!(arr.count>0))
        {
            NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([CustomerDetails class]) inManagedObjectContext:mYcontext];
            CustomerDetails *cstD=[[CustomerDetails alloc]initWithEntity:entity insertIntoManagedObjectContext:mYcontext];
            cstD.account_Balance__c=[NSString stringWithFormat:@"%@",obj[@"Account_Balance__c"]];
            cstD.active__c=obj[@"Active__c"];
            cstD.category_Type__c=obj[@"Category_Type__c"];
            cstD.category__c=obj[@"Category__c"];
            cstD.credit_Limit__c=[NSString stringWithFormat:@"%@",obj[@"Credit_Limit__c"]];
            cstD.discount__c=[NSString stringWithFormat:@"%@",obj[@"Discount__c"]];
            cstD.name=obj[@"Name"];
            cstD.ownerId=obj[@"OwnerId"];
            cstD.payment_Terms_Code__c=[NSString stringWithFormat:@"%@",obj[@"Payment_Terms_Code__c"]];
            cstD.price_List_No__c=[NSString stringWithFormat:@"%@",obj[@"Price_List_No__c"]];
            cstD.region__c=obj[@"Region__c"];
            cstD.service_Period__c=obj[@"Service_Period__c"];
            cstD.group_No__c=[NSString stringWithFormat:@"%@",obj[@"Group_No__c"]];
            cstD.group_Type__c=obj[@"Group_Type__c"];
            cstD.bP_Code__c=obj[@"BP_Code__c"];
            cstD.contact_Person__c=obj[@"Contact_Person__c"];
            cstD.x0_30__c=[NSString stringWithFormat:@"%@",obj[@"X0_30__c"]];
            cstD.ageing_Date__c=obj[@"Ageing_Date__c"];
            cstD.x121_150__c=[NSString stringWithFormat:@"%@",obj[@"X121_150__c"]];
            cstD.x151_180__c=[NSString stringWithFormat:@"%@",obj[@"X151_180__c"]];
            cstD.x181_240__c=[NSString stringWithFormat:@"%@",obj[@"X181_240__c"]];
            cstD.x241_300__c=[NSString stringWithFormat:@"%@",obj[@"X241_300__c"]];
            cstD.x301_360__c=[NSString stringWithFormat:@"%@",obj[@"X301_360__c"]];
            cstD.x31_60__c  =[NSString stringWithFormat:@"%@",obj[@"X31_60__c"]];
            cstD.x361__c=[NSString stringWithFormat:@"%@",obj[@"X361__c"]];
            cstD.x61_90__c=[NSString stringWithFormat:@"%@",obj[@"X61_90__c"]];
            cstD.x91_120__c=[NSString stringWithFormat:@"%@",obj[@"X91_120__c"]];
            cstD.customer_Name__c=obj[@"Customer_Name__c"];
            cstD.codeId=obj[@"Id"];
            
            NSDictionary *attDic=obj[@"attributes"];
            if(obj[@"attributes"]!=[NSNull null])
            {
                NSEntityDescription *entityAtt=[NSEntityDescription entityForName:NSStringFromClass([CAttributes class]) inManagedObjectContext:mYcontext];
                CAttributes *attrib=[[CAttributes alloc]initWithEntity:entityAtt insertIntoManagedObjectContext:mYcontext];
                attrib.url=attDic[@"url"];
                attrib.type=attDic[@"type"];
                
                cstD.atribute=attrib;//Adding
            }
            
            NSDictionary *billDic=obj[@"BillingAddress"];
            if(obj[@"BillingAddress"]!=[NSNull null])
            {
                NSEntityDescription *entityBill=[NSEntityDescription entityForName:NSStringFromClass([CBillingAddressC class]) inManagedObjectContext:mYcontext];
                CBillingAddressC *billingE=[[CBillingAddressC alloc]initWithEntity:entityBill insertIntoManagedObjectContext:mYcontext];
                billingE.city=formatStr(billDic[@"city"]);
                billingE.country=formatStr(billDic[@"country"]);
                billingE.countryCode=formatStr(billDic[@"countryCode"]);
                billingE.geocodeAccuracy=formatStr(billDic[@"geocodeAccuracy"]);
                billingE.latitude=formatStr(billDic[@"latitude"]);
                billingE.longitude=formatStr(billDic[@"longitude"]);
                billingE.postalCode=formatStr(billDic[@"postalCode"]);
                billingE.state=formatStr(billDic[@"state"]);
                billingE.stateCode=formatStr(billDic[@"stateCode"]);
                billingE.street=formatStr(billDic[@"street"]);
                
                cstD.billingAddress=billingE;//Adding
            }
            
            NSDictionary *shipDic=obj[@"ShippingAddress"];
            if(obj[@"ShippingAddress"] != NULL)
            {
                NSEntityDescription *entiShip=[NSEntityDescription entityForName:NSStringFromClass([CShippingAddressC class]) inManagedObjectContext:mYcontext];
                CShippingAddressC *shipE=[[CShippingAddressC alloc]initWithEntity:entiShip insertIntoManagedObjectContext:mYcontext];
                shipE.city=formatStr(shipDic[@"city"]);
                shipE.country=formatStr(shipDic[@"country"]);
                shipE.countryCode=formatStr(shipDic[@"countryCode"]);
                shipE.geocodeAccuracy=formatStr(shipDic[@"geocodeAccuracy"]);
                shipE.latitude=formatStr(shipDic[@"latitude"]);
                shipE.longitude=formatStr(shipDic[@"longitude"]);
                shipE.postalCode=formatStr(shipDic[@"postalCode"]);
                shipE.state=formatStr(shipDic[@"state"]);
                shipE.stateCode=formatStr(shipDic[@"stateCode"]);
                shipE.street=formatStr(shipDic[@"street"]);
                
                cstD.shippingAddress=shipE;//Adding
            }
            NSDictionary *shipToDic=obj[@"Ship_to_Party__r"];
            if(obj[@"Ship_to_Party__r"]!=[NSNull null])
            {
                NSEntityDescription *shi2Party=[NSEntityDescription entityForName:NSStringFromClass([ShipToParty class]) inManagedObjectContext:mYcontext];
                ShipToParty *shipParty=[[ShipToParty alloc]initWithEntity:shi2Party insertIntoManagedObjectContext:mYcontext];
                shipParty.totalSize=formatStr(shipToDic[@"totalSize"]);
                shipParty.done=formatStr(shipToDic[@"done"]);
                
                if(shipToDic[@"records"]!=[NSNull null])
                {
                    NSArray *arrRec=shipToDic[@"records"];
                    [arrRec enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        NSDictionary *dicRec=obj;
                        NSEntityDescription *recEntity=[NSEntityDescription entityForName:NSStringFromClass([Records class]) inManagedObjectContext:mYcontext];
                        Records *rec=[[Records alloc]initWithEntity:recEntity insertIntoManagedObjectContext:mYcontext];
                        rec.customerName__c=formatStr(dicRec[@"CustomerName__c"]);
                        rec.codeID=formatStr(dicRec[@"Id"]);
                        rec.name=formatStr(dicRec[@"Name"]);
                        rec.block__c=formatStr(dicRec[@"Block__c"]);
                        rec.cardCode__c=formatStr(dicRec[@"CardCode__c"]);
                        rec.city__c=formatStr(dicRec[@"City__c"]);
                        rec.country__c=formatStr(dicRec[@"Country__c"]);
                        rec.state__c=formatStr(dicRec[@"State__c"]);
                        rec.street__c=formatStr(dicRec[@"Street__c"]);
                        rec.street_No__c=formatStr(dicRec[@"Street_No__c"]);
                        rec.zipcode__c=formatStr(dicRec[@"Zipcode__c"]);
                        [shipParty addRecordsObject:rec];
                        
                        NSDictionary *attDic=dicRec[@"attributes"];
                        NSEntityDescription *recAtt=[NSEntityDescription entityForName:NSStringFromClass([CAttributes class]) inManagedObjectContext:mYcontext];
                        CAttributes *catt=[[CAttributes alloc]initWithEntity:recAtt insertIntoManagedObjectContext:mYcontext];
                        catt.type=attDic[@"type"];
                        catt.url=attDic[@"url"];
                        
                        rec.attribute=catt;
                        
                    }];
                    cstD.shipToParty=shipParty;
                }
            }
            
            
            
            
            NSLog(@"Saved customer--%lu",(unsigned long)idx);
            [delegate saveContextForProducts];
            [self fetchAllsavedCustomers];
        }
        
        
    }];
}
-(void)fetchAllsavedCustomers
{
    AppDelegate *delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext*  mYcontext=delegate.customerManagerObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([CustomerDetails class]) inManagedObjectContext:mYcontext];
    [fetchRequest setEntity:entity];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF like SELF"];
//    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [mYcontext executeFetchRequest:fetchRequest error:&error];
    [fetchedObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [ronakGlobal.coreDataCustomers addObject:obj];
    }];

}






@end
