//
//  OrderStatusCell.m
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusCell.h"
#import "RepotrsPopTV.h"
@implementation OrderStatusCell{
    
    OrderStatusViewController *orderStatusVC;
    OrderStatusCustomResponse *currentresponse;
    NSMutableArray *tvData;
    NSInteger *indexInteger;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    tvData=[[NSMutableArray alloc]init];
    UITapGestureRecognizer *downloadTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dowloadToPdf:)];
    downloadTap.numberOfTapsRequired=1;
    [_downloadImgVw addGestureRecognizer:downloadTap];
    
    
    UITapGestureRecognizer *emailTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendEmail:)];
    emailTap.numberOfTapsRequired=1;
    [_emailImageVw addGestureRecognizer:emailTap];
}
-(void)dowloadToPdf:(id)sender{
    
    [self convertToImages];
    
}
-(void)sendEmail:(id)sender{
    
    [self dowloadToPdf:nil];
    if ([MFMailComposeViewController canSendMail])
    {
        NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString* documentDirectory = [documentDirectories objectAtIndex:0];
        NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[orderStatusFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.pdf",_sfID.text,(int)indexInteger]]];
        NSLog(@"%@",documentDirectoryFilename);
        
        
        NSString *emailTitle = [NSString stringWithFormat:@"Order Status of the Cutomer %@",_sfID.text];
        NSString *messageBody = @"";
        NSArray *toRecipents = [NSArray arrayWithObject:@""];
        NSString *path = [[NSBundle mainBundle] pathForResource:documentDirectoryFilename ofType:@"pdf"];
        NSData *myData= [NSData dataWithContentsOfFile:documentDirectoryFilename];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc addAttachmentData:myData mimeType:@"application/pdf" fileName:[_sfID.text stringByAppendingPathExtension:@"pdf"]];
        [mc setToRecipients:toRecipents];
        [orderStatusVC presentViewController:mc animated:YES completion:NULL];
    }
    else
    {
        showMessage(@"Please Configure Mail Settings in your Device", orderStatusVC.view);
    }

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(OrderStatusCustomResponse*)resp superViewCon:(OrderStatusViewController*)superVc withIndex:(NSInteger*)integer;
{
    indexInteger=integer;
    _dateLbl.text=@"";
    _brandLabel.text=@"";
    _qtyLabel.text=@"";
    _invoiceIDLbl.text=@"";
    _customerNameLabel.text=@"";
    _discLabel.text=@"";
    _amountLabel.text=@"";
    [_statusBtn setTitle:@"" forState:UIControlStateNormal];
    
    [_sfID setAdjustsFontSizeToFitWidth:YES];
    [_invoiceIDLbl setAdjustsFontSizeToFitWidth:YES];
    [_dateLbl setAdjustsFontSizeToFitWidth:YES];
    
    _sfID.text=resp.Name;
    _customerNameLabel.text=resp.Customer_Name__c;
    orderStatusVC=superVc;
    currentresponse=resp;
    _dateLbl.text=resp.CreatedDate;
    _brandLabel.text=resp.Brand__c;
    _qtyLabel.text=resp.Quantity__c;
    _discLabel.text=resp.Discount__c;
    _amountLabel.text=resp.Net_Amount__c;
    _dateLbl.text=[resp.CreatedDate substringToIndex:10];
    
    [self getDatesToshowStatus:resp];
    if(resp.typeOfRec==INVOICE_Type)
    {
        _dateLbl.text=@"";
        _invoiceIDLbl.text=resp.record.typeName;
        _dateLbl.text=resp.record.typeDate__c;
    }
    if(resp.typeOfRec==DELIVERY_Type)
    {
        _dateLbl.text=@"";
        _dateLbl.text=resp.record.typeDate__c;
    }
    
}
-(void)getDatesToshowStatus:(OrderStatusCustomResponse*)respData
{
    if(respData.CreatedDate)
    {
        [tvData addObject:@"SR"];
    }
    if(respData.RSM_Date__c)
    {
        [tvData addObject:@"RSM"];
    }
    if(respData.HOD_Date__c)
    {
        [tvData addObject:@"HOD"];
    }
    if(respData.MD_Date__c)
    {
        [tvData addObject:@"MD"];
    }
    if(respData.SAP_Date__c)
    {
        [tvData addObject:@"SAP"];
    }
    if(respData.Sale_Order_Date__c)
    {
        [tvData addObject:@"SO"];
    }    
    [_statusBtn setTitle:tvData.lastObject forState:UIControlStateNormal];
}
- (IBAction)statusClick:(id)sender {
    
    [orderStatusVC.reportStatus bindData:currentresponse];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [orderStatusVC dismissViewControllerAnimated:YES completion:NULL];
}
-(void)convertToImages
{
    CGRect rect = [orderStatusVC.headingsView bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, orderStatusVC.headingsView.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [orderStatusVC.headingsView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGRect rect1 = [self.contentView bounds];
    UIGraphicsBeginImageContextWithOptions(rect1.size, self.contentView.opaque, 0.0);
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    [self.contentView.layer renderInContext:context2];
    UIImage *img2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGSize newSize = CGSizeMake(img.size.width,img.size.height+img2.size.height);
    UIGraphicsBeginImageContext( newSize );
    // Use existing opacity as is
    [img drawInRect:CGRectMake(0,0,img.size.width,img.size.height)];
    // Apply supplied opacity if applicable
    [img2 drawInRect:CGRectMake(0,img.size.height,img2.size.width,img2.size.height) blendMode:kCGBlendModeNormal alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    NSData * binaryImageData2 = UIImagePNGRepresentation(newImage);
//    [binaryImageData2 writeToFile:[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.sfID.text]] atomically:YES];
    
    UIImageView *imgV=[[UIImageView alloc]initWithImage:newImage];
    [self createPDFfromUIViews:imgV saveToDocumentsWithFileName:[NSString stringWithFormat:@"%@%d.pdf",_sfID.text,(int)indexInteger]];
}

- (void)createPDFfromUIViews:(UIView *)myImage saveToDocumentsWithFileName:(NSString *)string
{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, myImage.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    [myImage.layer renderInContext:pdfContext];
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[orderStatusFolder stringByAppendingPathComponent:string]];
    NSLog(@"%@",documentDirectoryFilename);
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    showMessage(@"Status Saved as PDF ", orderStatusVC.view);
}


@end
