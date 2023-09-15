component {

    public void function init(fw) {
        VARIABLES.fw = ARGUMENTS.fw;
    }

    function setBeanFactory(beanFactory){
        VARIABLES.beanFactory = beanFactory;
    }

    public void function before(){
        param name="rc.messages" default=[];
        param name="rc.errors" default=[];
    }

    public void function login(rc) {
        param name="rc.login" default="";
        param name="rc.passwd" default="";
        param name="rc.subscriberSecret" default=""; // comes from application settings

        //param name="rc.fbUserID" default="0";
        //param name="rc.fbUserName" default="";
        //param name="rc.fbUserAccessToken" default="";

        //var jsonBody = {};
        //LOCAL.jsonBody['login'] = rc.login;
        //LOCAL.jsonBody['passwd'] = rc.passwd;

        var username = rc.login;
        var passwd = rc.passwd;
        var secpasswd = hmac(passwd, rc.subscriberSecret, "HMACSHA1");

        if (Len(rc.login) GT 0 AND Len(rc.passwd) GT 0) {

			var timing = GetTickCount();

            http url="#rc.serviceURL#/users/login/"
                 method="post"
                 result="jsonUser"
                 proxyserver="#APPLICATION.proxyServer#"
                 proxyport="#APPLICATION.proxyPort#"
                 username="#LOCAL.username#"
                 password="#LOCAL.secpasswd#";

            rc.metrics.api = GetTickCount() - LOCAL.timing;

            if(jsonUser.responseHeader.Status_Code EQ 200){
                var user = DeserializeJSON(jsonUser.filecontent);
                if(StructKeyExists(LOCAL.user, "id")){
                    ArrayAppend(rc.messages, "Welcome, " & LOCAL.user.firstname);
                }

                rc.user = VARIABLES.beanFactory.getBean("User");
                rc.user.setID(LOCAL.user.id);
                rc.user.setLogin(LOCAL.user.login);
                rc.user.setFirstName(LOCAL.user.firstname);
                rc.user.setLastName(LOCAL.user.lastname);
                rc.user.setEmail(LOCAL.user.email);
                rc.user.setCreated(LOCAL.user.created);
                rc.user.setMoment(LOCAL.user.moment);
                rc.user.setSessionToken(LOCAL.user.sessiontoken);
                rc.user.setTokens(LOCAL.user.tokens);

                SESSION.user = rc.user;

                VARIABLES.fw.redirect(action="home.dashboard", preserve="user,messages,errors");
            }else{
                var error = DeserializeJSON(jsonUser.filecontent);
                ArrayAppend(rc.errors, LOCAL.error);

                if(LOCAL.error EQ "E_SESSION_NOT_FOUND" OR LOCAL.error EQ "E_SUBSCRIBER_NOT_FOUND"){
                    StructDelete(SESSION, "user");
                    StructDelete(rc, "user");
                }

                VARIABLES.fw.redirect(action="home.login", preserve="errors");
            }
        }
    }

    public void function logout(rc) {

    	var timing = GetTickCount();

        http url="#rc.serviceURL#/users/logout/" method="post" result="jsonUser" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        if(jsonUser.responseHeader.Status_Code EQ 200){
            var user = DeserializeJSON(jsonUser.filecontent);
            if(StructKeyExists(LOCAL.user, "id")){
                ArrayAppend(rc.messages, "You was logged out, " & LOCAL.user.firstname);
            }

            SESSION.user = VARIABLES.beanFactory.getBean("User");;
        }else{
            var error = DeserializeJSON(jsonUser.filecontent);
            ArrayAppend(rc.errors, LOCAL.error);
        }

        VARIABLES.fw.redirect(action="home.login", preserve="user,messages,errors");
    }

}