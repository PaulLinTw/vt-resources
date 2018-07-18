db = db.getSiblingDB('demo');
print("Use Database Demo");

db.view_promotions.drop();

db.createView( 	
	"view_promotions", 	// View Title
	
	"campaigns",  		// Source
	[ 			// pipeline
		//{ $match: { "_id":1}},
		{ $lookup: { from: "channels", localField: "_id", foreignField: "campaign", as: "eApplicationChannel" }
		},
		{  $unwind: "$eApplicationChannel"
   		},
		{ $match: { "eApplicationChannel.appChanValue":"660-Activation"}},
		{ $lookup: { from: "contracts", localField: "_id", foreignField: "campaign", as: "contractAffterTermination" } 
		},
		{  $unwind: "$contractAffterTermination"
   		},
		{ $addFields: { TotalonLineTimes : "$onLineTimes" } },
		{ $project: { 	"isDesignationGoods": 0, "commissionCategory": 0, "noteText": 0, "labelContractPeriod": 0,  
					"eApplicationChannel._id": 0, "eApplicationChannel.sku": 0, 
					"contractAffterTermination._id": 0, "contractAffterTermination.sku": 0 }
		}		
	]
)
print("view promotions created");