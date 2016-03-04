
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.job("deleteOldEntries", function(request, status) {
    Parse.Cloud.useMasterKey();
    var today = new Date();
    var days = 1;
    var time = (days * 24 * 3600 * 1000);
    var expirationDate = new Date(today.getTime() - (time));
    var query = new Parse.Query("Post");

    query.lessThan("sTime", expirationDate);
    query.find().then(function (posts) {
        Parse.Object.destroyAll(posts, {
            success: function() {
                status.success("All posts are removed.");
                },
                error: function(error){
                    status.error("Error, posts are not removed.");
                    }
                });
            }, function (error) {});
});
