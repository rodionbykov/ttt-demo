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
        param name="rc.messages" default=[];
        param name="rc.errors" default=[];
    }

    public void function list(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/" method = "get" result="jsonTasks" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrTasks = DeserializeJSON(jsonTasks.filecontent);
    }

    public void function new(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/" method="get" result="jsonProjects" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrProjects = DeserializeJSON(jsonProjects.filecontent);
    }

    public void function edit(rc){

        param name="rc.id" default="0";

        var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/" method="get" result="jsonProjects" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        http url="#rc.serviceURL#/tasks/#rc.id#/" method = "get" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrProjects = DeserializeJSON(jsonProjects.filecontent);
        rc.structTask = DeserializeJSON(jsonTask.filecontent);
    }

    public void function add(rc){

        param name="rc.taskTitle" default="";
        param name="rc.taskProjectID" default="";
        param name="rc.taskDescription" default="";

        var jsonBody = {title: rc.taskTitle, description: rc.taskDescription};

        if(rc.taskProjectID NEQ "" AND IsNumeric(rc.taskProjectID)){
            jsonBody['projectid'] = rc.taskProjectID;
        }

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/" method="post" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.task = DeserializeJSON(jsonTask.filecontent);
        // TODO why such name ?
        if(jsonTask.responseHeader.Status_Code EQ 200){
            if(StructKeyExists(rc.task, "id")){
                ArrayAppend(rc.messages, "Task added");
            }
        }else{
            ArrayAppend(rc.errors, rc.task);
        }

        VARIABLES.framework.redirect(action="tasks.list", preserve="task,messages,errors");
    }

    public void function view(rc){

        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/#rc.id#/" method="get" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structTask = DeserializeJSON(jsonTask.filecontent);
    }


    public void function save(rc){

        param name="rc.id" default="0";
        param name="rc.taskTitle" default="";
        param name="rc.taskProjectID" default="";
        param name="rc.taskDescription" default="";

        var jsonBody = {title: rc.taskTitle, description: rc.taskDescription};

        if(rc.taskProjectID NEQ "" AND IsNumeric(rc.taskProjectID) AND rc.taskProjectID GT 0){
            jsonBody['projectid'] = rc.taskProjectID;
        }

        var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/#rc.id#/" method="post" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.task = DeserializeJSON(jsonTask.filecontent);

        if(jsonTask.responseHeader.Status_Code EQ 200){
            if(StructKeyExists(rc.task, "id")){
                ArrayAppend(rc.messages, "Task saved");
            }
        }else{
            ArrayAppend(rc.errors, rc.task);
        }

        VARIABLES.framework.redirect(action="tasks.list", preserve="task,messages,errors");
    }

    public void function quickstart(rc){

        param name="rc.title" default="";
        param name="rc.description" default="";

        var structBody = StructNew();
        structBody.title = rc.title;
        structBody.description = rc.description;

        var jsonBody = SerializeJSON(structBody);
        var binaryBody = ToBinary( ToBase64(jsonBody, "utf-8") );

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/" method="put" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#binaryBody#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        if(jsonActivity.status_code EQ 200){
            rc.structActivity = DeserializeJSON(jsonActivity.filecontent);
            if(StructKeyExists(rc.structActivity, "task")){
                rc.id = rc.structActivity.task.id;
                ArrayAppend(rc.messages, "Task quickstarted");
                VARIABLES.framework.redirect(action="tasks.view", preserve="messages,errors", append="id");
            }else{
                VARIABLES.framework.redirect(action="tasks.list");
            }
        }else{
            ArrayAppend(rc.errors, jsonActivity.filecontent);
            VARIABLES.framework.redirect(action="tasks.list", preserve="errors");
        }
                
    }

    public void function quickstartactivity(rc){

        param name="rc.description" default="";

        var structBody = StructNew();
        structBody.description = rc.description;

        var jsonBody = SerializeJSON(structBody);
        var binaryBody = ToBinary( ToBase64(jsonBody, "utf-8") );

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/#rc.taskid#/" method="put" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#binaryBody#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;
        
        if(jsonActivity.status_code EQ 200){
            rc.structActivity = DeserializeJSON(jsonActivity.filecontent);
            if(StructKeyExists(rc.structActivity, "task")){
                rc.id = rc.structActivity.task.id;
                ArrayAppend(rc.messages, "Activity quickstarted");
                VARIABLES.framework.redirect(action="tasks.view", preserve="messages", append="id");
            }else{
                VARIABLES.framework.redirect(action="tasks.list");
            }
        }else{
            ArrayAppend(rc.errors, jsonActivity.filecontent);
            VARIABLES.framework.redirect(action="tasks.list", preserve="messages,errors");
        }


    }

    public void function toggleactivity(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/activities/#rc.id#/" method="patch" result="jsonActivity" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structActivity = DeserializeJSON(jsonActivity.filecontent);
        rc.id = rc.structActivity.task.id;

        VARIABLES.framework.redirect(action="tasks.view", append="id");
    }

    public void function stop(rc){

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/#rc.id#/" method="patch" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structTask = DeserializeJSON(jsonTask.filecontent);

        VARIABLES.framework.redirect(action="tasks.list");
    }

    public void function remove(rc){
        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/#rc.id#/" method="delete" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.task = DeserializeJSON(jsonTask.filecontent);
        
        if(jsonTask.status_code EQ "200" AND StructKeyExists(rc.task, "id")){
            ArrayAppend(rc.messages, "Task removed");
        }else{
            ArrayAppend(rc.errors, rc.task);
        }

        VARIABLES.framework.redirect(action="tasks.list", preserve="task,messages,errors");
    }

}