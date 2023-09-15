component {

    function init(fw){
        VARIABLES.framework = fw;
        return THIS;
    }

    function setBeanFactory(beanFactory){
        VARIABLES.beanFactory = beanFactory;
    }

    public void function before(){
        // wait until subsystem be ready
        //rc.user = VARIABLES.beanFactory.getBean("User");
        param name="rc.messages" default=[];
        param name="rc.errors" default=[];
    }

    public void function list(rc){

        var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/" method="get" result="jsonProjects" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrProjects = DeserializeJSON(jsonProjects.filecontent);
    }


    public void function view(rc){

        param name="rc.id" default="0";

	    var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/#rc.id#/" method = "get" result="jsonProject" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structProject = DeserializeJSON(jsonProject.filecontent);
    }

    public void function add(rc){

        param name="rc.projectName" default="";
        param name="rc.projectDescription" default="";

        var jsonBody = {name: rc.projectName, description: rc.projectDescription};

		var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/" method="post" result="jsonProject" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.project = DeserializeJSON(jsonProject.filecontent);

        if(jsonProject.responseHeader.Status_Code EQ 200){
            if(StructKeyExists(rc.project, "id")){
                ArrayAppend(rc.messages, "Project added");
            }
        }else{
            ArrayAppend(rc.errors, rc.project);
        }

        VARIABLES.framework.redirect(action="projects.list", preserve="project,messages,errors");
    }

    public void function edit(rc){

        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/#rc.id#/" method="get" result="jsonProject" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.project = DeserializeJSON(jsonProject.filecontent);
        // TODO check http status, if error - redirect
    }

    public void function save(rc){

        param name="rc.id" default="0";
        param name="rc.projectName" default="";
        param name="rc.projectDescription" default="";

        var jsonBody = {name: rc.projectName, description: rc.projectDescription};

		var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/#rc.id#/" method="post" result="jsonProject" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.project = DeserializeJSON(jsonProject.filecontent);

        // TODO check http status, not id
        if(StructKeyExists(rc.project, "id")){
            ArrayAppend(rc.messages, "Project saved");
        }else{
            ArrayAppend(rc.errors, rc.project);
        }

        VARIABLES.framework.redirect(action="projects.list", preserve="project,messages,errors");
    }

    public void function remove(rc){
        param name="rc.id" default="0";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/projects/#rc.id#/" method="delete" result="jsonProject" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.project = DeserializeJSON(jsonProject.filecontent);

        // TODO check http status, not id
        if(StructKeyExists(rc.project, "id")){
            ArrayAppend(rc.messages, "Project removed");
        }else{
            ArrayAppend(rc.errors, rc.project);
        }

        VARIABLES.framework.redirect(action="projects.list", preserve="project,messages,errors");
    }

    public void function quickstarttask(rc){

        param name="rc.projectid" default="0";
        param name="rc.title" default="";
        param name="rc.description" default="";

        var jsonBody = {title: rc.title, description: rc.description};

        if(IsNumeric(rc.projectid) AND rc.projectid GT 0){
            LOCAL.jsonBody.projectid = rc.projectid;
        }

		var timing = GetTickCount();

        http url="#rc.serviceURL#/tasks/" method="put" result="jsonTask" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
            httpparam type="header" name="Content-Type" value="application/json; charset=utf-8";
            httpparam type="body" value="#ToBinary( ToBase64( SerializeJSON(LOCAL.jsonBody) ) )#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        if(jsonTask.status_code EQ 200){
            rc.structTask = DeserializeJSON(jsonTask.filecontent);

            if(StructKeyExists(rc.structTask, "project_id") AND rc.structTask.project_id GT 0){
                rc.id = rc.structTask.project_id;
                ArrayAppend(rc.messages, "Task quickstarted");
                VARIABLES.framework.redirect(action="projects.view", preserve="id,messages");
            }else{                
                VARIABLES.framework.redirect(action="tasks.list");
            }
        }else{
            ArrayAppend(rc.errors, jsonTask.filecontent);
            VARIABLES.framework.redirect(action="tasks.list", preserve="errors");
        }

    }

}