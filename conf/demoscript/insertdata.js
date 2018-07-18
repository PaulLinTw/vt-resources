db = db.getSiblingDB('demo');
print("Use Database Demo");

db.createCollection( "campaigns",
   {
      validator: { $and:
         [
            { gift: { $in: [ "是", "否" ] } },
            { happyGo: { $type: "string", $regex: "^\[0-9\]\{1\}$" } },
			{ onLineVersion: { $type: "string", $regex: "^\[0-9\]\{1\}\.\[0-9\]\{2\}$" } },
			{ groupPromotion: { $type: "string", $regex: /^[A-Z]+$/ } },
            { offerId: { $type: "string", $regex: "^\[0-9\]\{6\}$" } }
         ]
      },
      validationAction: "error"
   })
print("Collection campaigns created");

db.createCollection( "channels",
   {
      validator: { $and:
         [
            { appChanValue: { $type: "string"} },
			{ appChanCreateDate: { $type: "string", $regex: "^\[0-9\]\{4\}\-\[0-9\]\{2\}\-\[0-9\]\{2\}T\[0-9\]\{2\}\:\[0-9\]\{2\}\:\[0-9\]\{2\}$" } },
			{ appChanCode: { $type: "string", $regex: "^\[0-9\]\{1\}$" } }
         ]
      },
      validationAction: "error"
   })
print("Collection channels created");

db.createCollection( "contracts",
   {
      validator: { $and:
         [
            { conDate: { $type: "string", $regex: "^\[0-9\]\{4\}\-\[0-9\]\{2\}\-\[0-9\]\{2\}T\[0-9\]\{2\}\:\[0-9\]\{2\}\:\[0-9\]\{2\}$" } },
            { conCode: { $type: "string", $regex: /^[0-9]+$/ } }
         ]
      },
      validationAction: "error"
   }
)
print("Collection contracts created");

db.campaigns.insert(
	[
		{	_id: nextseq("campaignid"),
			gift:"否", 
			isDesignationGoods:"是", 
			noteText:"本專案生效日為系統啟用日，新費率將於申請變更後第一個帳單結帳日開始生效。", 
			exchangeContract:"否", 
			happyGo:"0", 
			eOptionalContract:"164054-4G語音0型", 
			gsmContractSoc: "最低月租費：164054-4G語音0型", 
			mIaSubsidy:"一般", 
			eInitSys:"ALL", 
			prepayment: "無預繳(N)", 
			msisdnType:"4G", 
			spvNo:"20151125012", 
			commimentHighToLow:"二十四個月", 
			loyaltyDefinition:"A2411-易付轉月租_政府補貼2G易付精選", 
			promotionType:"新啟用-4G啟用攜碼專用", 
			margin:"0", 
			cba:"0", 
			dataType:"Data類促代", 
			labelContractPeriod:"二十四個月", 
			commissionCategory:"【手機\/其他類商品專案】", 
			onLineTimes:"2", 
			onLineVersion:"2.01", 
			srNo:"20151125012", 
			groupPromotion:"NA",
			eSalePeriod:"IAFS有效起始日 20151107 ~ 20151125", 
			offerId:"554113", 
			eOptionalDataService:"164086-4G高速飆網199"
		},
		{	_id: nextseq("campaignid"),
			gift:"是", 
			isDesignationGoods:"是", 
			noteText:"本專案生效日為系統啟用日，新費率將於申請變更後第一個帳單結帳日開始生效。", 
			exchangeContract:"否", 
			happyGo:"0", 
			eOptionalContract:"164054-4G語音0型", 
			gsmContractSoc: "最低月租費：164054-4G語音0型", 
			mIaSubsidy:"一般", 
			eInitSys:"ALL", 
			prepayment: "無預繳(N)", 
			msisdnType:"3G", 
			spvNo:"20151125024", 
			commimentHighToLow:"二十四個月", 
			loyaltyDefinition:"A2411-易付轉月租_政府補貼2G易付精選", 
			promotionType:"新啟用-4G啟用攜碼專用", 
			margin:"0", 
			cba:"1", 
			dataType:"Data類促代", 
			labelContractPeriod:"二十四個月", 
			commissionCategory:"【手機\/其他類商品專案】", 
			onLineTimes:"2", 
			onLineVersion:"2.01", 
			srNo:"20151125012", 
			groupPromotion:"NA",
			eSalePeriod:"IAFS有效起始日 20151107 ~ 20151125", 
			offerId:"554110", 
			eOptionalDataService:"164086-4G高速飆網199"
		},
		{	_id: nextseq("campaignid"),
			gift:"否", 
			isDesignationGoods:"否", 
			noteText:"新費率將於申請變更後第一個帳單結帳日開始生效。", 
			exchangeContract:"否", 
			happyGo:"0", 
			eOptionalContract:"164054-4G語音1型", 
			gsmContractSoc: "最低月租費：164054-4G語音0型", 
			mIaSubsidy:"一般", 
			eInitSys:"ALL", 
			prepayment: "預繳(1000)", 
			msisdnType:"4G", 
			spvNo:"20151125022", 
			commimentHighToLow:"一十二個月", 
			loyaltyDefinition:"A2411-易付轉月租_政府補貼2G易付精選", 
			promotionType:"新啟用-4G啟用攜碼專用", 
			margin:"0", 
			cba:"0", 
			dataType:"Data類促代", 
			labelContractPeriod:"二十四個月", 
			commissionCategory:"【手機\/其他類商品專案】", 
			onLineTimes:"2", 
			onLineVersion:"2.01", 
			srNo:"20151125012", 
			groupPromotion:"NA",
			eSalePeriod:"IAFS有效起始日 20151107 ~ 20151125", 
			offerId:"554113", 
			eOptionalDataService:"164086-4G高速飆網199"
		},
		{	_id: nextseq("campaignid"),
			gift:"是", 
			isDesignationGoods:"是", 
			noteText:"本專案生效日為系統啟用日，新費率將於申請變更後第一個帳單結帳日開始生效。", 
			exchangeContract:"否", 
			happyGo:"0", 
			eOptionalContract:"164054-4G語音0型", 
			gsmContractSoc: "最低月租費：164054-4G語音0型", 
			mIaSubsidy:"一般", 
			eInitSys:"ALL", 
			prepayment: "無預繳(N)", 
			msisdnType:"4G", 
			spvNo:"20151125024", 
			commimentHighToLow:"二十四個月", 
			loyaltyDefinition:"A2411-易付轉月租_政府補貼4G易付精選", 
			promotionType:"新啟用-4G啟用攜碼專用", 
			margin:"0", 
			cba:"1", 
			dataType:"語音類促代", 
			labelContractPeriod:"三十六個月", 
			commissionCategory:"【手機\/其他類商品專案】", 
			onLineTimes:"2", 
			onLineVersion:"2.01", 
			srNo:"20151125012", 
			groupPromotion:"NA",
			eSalePeriod:"IAFS有效起始日 20151107 ~ 20151125", 
			offerId:"554110", 
			eOptionalDataService:"164086-4G高速飆網199"
		},
	]
)
print("documents of campaigns inserted");

db.channels.insert(
		[	{ _id: nextseq("channelid"), campaign: 1, appChanValue:"660-Activation", appChanCreateDate:"2015-11-11T12:31:00", appChanCode:"1" },
			{ _id: nextseq("channelid"), campaign: 2, appChanValue:"660-Activation", appChanCreateDate:"2016-11-11T12:31:00", appChanCode:"3" },
			{ _id: nextseq("channelid"), campaign: 4 , appChanValue:"直營門市", appChanCreateDate:"2013-11-11T12:31:00", appChanCode:"2" },
			{ _id: nextseq("channelid"), campaign: 3 , appChanValue:"直營門市", appChanCreateDate:"2014-11-11T12:31:00", appChanCode:"4" }
		]
)
print("documents of channels inserted");

db.contracts.insert(
		[	{  _id: nextseq("contractid"), campaign: 1 , conDate:"2015-11-11T12:31:00", conValue:"164055-4G絕配語音0型", conCode:"164055"}, 
			{  _id: nextseq("contractid"), campaign: 1 , conDate:"2013-11-11T12:31:00", conValue:"164055-4G絕配語音U型", conCode:"164053"}, 
			{  _id: nextseq("contractid"), campaign: 2 , conDate:"2016-11-11T12:31:00", conValue:"164054-4G語音0型", conCode:"164054"},
			{  _id: nextseq("contractid"), campaign: 4 , conDate:"2014-11-11T12:31:00", conValue:"164054-4G語音0型", conCode:"164051"}
		]
)
print("documents of contracts inserted");