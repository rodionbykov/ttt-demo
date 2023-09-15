component {
    pageEncoding "utf-8";

    function init(fw){
        VARIABLES.framework = fw;
        return THIS;
    }

    function setBeanFactory(beanFactory){
        VARIABLES.beanFactory = beanFactory;
    }

    public void function before(){
        //rc.user = VARIABLES.beanFactory.getBean("User");
        param name="rc.messages" default=[];
        param name="rc.errors" default=[];
    }

    public void function list(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/" method="get" result="jsonActivities" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrActivities = DeserializeJSON(jsonActivities.filecontent);
    }

    public void function new(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/" method = "get" result="jsonTasks" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrTasks = DeserializeJSON(jsonTasks.filecontent);
    }

    public void function view(rc){

        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="get" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structActivity = DeserializeJSON(jsonActivity.filecontent);
    }

    public void function edit(rc){

        param name="rc.id" default="0";

        var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="get" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        http url="#rc.serviceURL#/tasks/" method = "get" result="jsonTasks" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structActivity = DeserializeJSON(jsonActivity.filecontent);
        rc.arrTasks = DeserializeJSON(jsonTasks.filecontent);
    }

    public void function add(rc){

        param name="rc.taskID" default="";
        param name="rc.activityDescription" default="";

        var jsonBody = {description: rc.activityDescription};

        if(rc.taskID NEQ "" AND IsNumeric(rc.taskID)){
            jsonBody['taskid'] = rc.taskID;
        }

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/" method="post" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.actitity = DeserializeJSON(jsonActivity.filecontent);

        if(jsonActivity.responseHeader.Status_Code EQ 200){
            if(StructKeyExists(rc.actitity, "id")){
                ArrayAppend(rc.messages, "Activity added");
            }
        }else{
            ArrayAppend(rc.errors, rc.actitity);
        }

        VARIABLES.framework.redirect(action="activities.list", preserve="actitity,messages,errors");
    }

    public void function save(rc){

        param name="rc.id" default="0";
        param name="rc.taskID" default="";
        param name="rc.activityDescription" default="";

        var jsonBody = {description: rc.activityDescription}

        if(rc.taskID NEQ "" AND IsNumeric(rc.taskID) AND rc.taskID GT 0){
            jsonBody['taskid'] = rc.taskID;
        }

        var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="post" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.activity = DeserializeJSON(jsonActivity.filecontent);

        if(jsonActivity.responseHeader.Status_Code EQ 200){
            if(StructKeyExists(rc.activity, "id")){
                ArrayAppend(rc.messages, "Activity saved");
            }
        }else{
            ArrayAppend(rc.errors, rc.activity);
        }

        VARIABLES.framework.redirect(action="activities.list", preserve="activity,messages,errors");
    }

    public void function toggle(rc){

        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="patch" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structActivity = DeserializeJSON(jsonActivity.filecontent);

        VARIABLES.framework.redirect(action="activities.list");
    }

    public void function quickstart(rc){

        param name="rc.description" default="";

        var structBody = StructNew();
        structBody.description = rc.description;

        var jsonBody = SerializeJSON(structBody);
        var binaryBody = ToBinary( ToBase64(jsonBody, "utf-8") );

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/" method="put" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#binaryBody#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structActivity = DeserializeJSON(jsonActivity.filecontent);

        VARIABLES.framework.redirect(action="activities.list");
    }

    public void function remove(rc){
        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="delete" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.activity = DeserializeJSON(jsonActivity.filecontent);

        // TODO check http status, not id
        if(StructKeyExists(rc.activity, "id")){
            ArrayAppend(rc.messages, "Activity removed");
        }else{
            ArrayAppend(rc.errors, rc.activity);
        }

        VARIABLES.framework.redirect(action="activities.list", preserve="activity,messages,errors");
    }

}