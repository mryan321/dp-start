var databases = [
	{
		name: "datasets",
		collections: ["datasets", "instances", "editions", "dimension.options"]
	},
	{
		name: "recipes",
		collections: ["recipes"]
	},
	{
		name: "filters",
		collections: ["filters", "filterOutputs"]
	},
	{
		name: "imports",
		collections: ["imports"]
	},
	{
		name: "search",
		collections: ["jobs", "jobs_locks"]
	},
	{
		name: "images",
		collections: ["images_locks"]
	}
];

for (database of databases) {
	db = db.getSiblingDB(database.name);

	for (collection of database.collections){
		db.createCollection(collection);
	}
}
