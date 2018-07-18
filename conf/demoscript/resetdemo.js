// Choose Database
db = db.getSiblingDB('demo');
print("Use Database Demo");

db.campaigns.drop();
db.channels.drop();
db.contracts.drop();
db.sequences.drop();
db.view_promotions.drop();
print("All Collections Dropped");

db.system.js.remove({})
print("All Server Side Script Removed");

db.system.js.save( 
	{	_id: 'decode', 
		value : function (origion, optionArray, defaultValue){	
			var x; 
			var option = optionArray[0]; 
			var trueValue = optionArray[1]; 
			if (origion == option) 
				{	x = trueValue; } 
			else 
				{	optionArray.splice(0, 2); 
			if ( optionArray.length>0 ) 
				{	x = decode(origion, optionArray, defaultValue) } 
			else 
				{ 	x = defaultValue; } } 
			return x; 
		} 
	} 
)
print("Function decode created");

db.system.js.save( 
	{	_id: 'nextseq', 
		value : function (name) {  
			var ret = db.sequences.findAndModify(
				{
					query: { _id: name },
					update: { $inc: { seq: 1 } },
					new: true
				}
			);
			return ret.seq; 
		} 
   } 
)
print("Function nextseq created");

db.loadServerScripts();
print("ServerScripts loadded");

db.sequences.insert(
   [	{ _id: "campaignid", seq: 0 },
		{ _id: "channelid", seq: 0 },
		{ _id: "contractid", seq: 0 }
	]
)
print("Sequences Prepared");