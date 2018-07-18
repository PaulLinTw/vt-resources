vt-resource contains reusable materials for vt. To utilize vt-resource, please add following item into global.json in your bvt project path:

	{
		"project": ...,
		"network": ...,
		"hosts": ...,
		"builder":...,
		"relatedprojects": ...,
	
		"resource": 
		{
			"site": "https://github.com/PaulLinTw/vt-resources.git",
			"tag": "master"
		}
	
	}

where site is url of vt-resource git repo, and tag must be a correct branch name, mostly "master" is used.

All materials are placed in three different location according to thie usage:

	basevm: files involves installation during the creation of vagrant box will be placed here.
	
	conf: files involves provision will be placed here.
	
	scripts: script files in all kinds will be placed here.
