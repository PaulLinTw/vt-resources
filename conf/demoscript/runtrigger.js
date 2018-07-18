db = db.getSiblingDB('local');
print("Use Database local");

function trigger(){	
	var cursor = db.oplog.rs.find();
	cursor.tailable( { isAwaitData : true } );
	cursor.skip(db.oplog.rs.count());
	var doc;
	while( true ) {
		if (cursor.hasNext()) {
			try {
				doc = cursor.next();
				if (doc.op!=='n'){
					print('');
					print('時戳 '+doc.ts);
					print('集合 '+doc.ns);
					print('操作 '+doc.op);
					if (doc.op=='i'){
						print("對象 _id");
						printjson(doc.o._id);
					}
					else if (doc.op=='u'){
						print("內容");
						printjson(doc.o.$set);
					}
					else if (doc.op=='c'){
						 if (doc.o.drop!==null){
							print("對象"+doc.o.drop);
							printjson(doc.o.drop);
						}
						else if (doc.o.create!==null){
							print("對象"+doc.o.create);
							printjson(doc.o.create);	
						}
						else {
							print("內容");
							printjson(doc.o);
						}
					}
					else {
						print("內容");
						printjson(doc.o);
					}
				}
			} catch (err) { 
				print(err);
			}
		}
		sleep(5);
	}
	return true; 
}

print("begin trigger function");
trigger();

