component accessors="true" {

    property beanFactory;

    public any login(login, passwd) {
        var result = VARIABLES.beanFactory.getBean("User");

        var jsondata = {'login':ARGUMENTS.login,'passwd':ARGUMENTS.passwd};

        http url="#APPLICATION.serviceURL#/users/login" method="POST" proxyserver="#APPLICATION.proxyServer#" proxyport ="#APPLICATION.proxyPort#" {
            httpparam type="body" value="#serializeJSON(jsondata)#";
        }

        jsondata = deserializeJSON(cfhttp.filecontent);

        if (jsondata.ID GT 0) {
            result.setID(jsondata.id);
            result.setLogin(jsondata.login);
            result.setFirstName(jsondata.firstname);
            result.setLastName(jsondata.lastname);
            result.setEmail(jsondata.email);
            result.setCreated(jsondata.created);
            result.setMoment(jsondata.moment);
            result.setSessionToken(jsondata.sessiontoken);

            var roles = ArrayNew(1);

            loop array="#jsondata.ROLES#" index="i" {
                ArrayAppend(roles, i.pluralname);
            }

            result.setRoles(LOCAL.roles);

            var tokens = ArrayNew(1);

            loop array="#jsondata.TOKENS#" index="i" {
                ArrayAppend(tokens, i.token);
            }

            result.setTokens(LOCAL.tokens);
        }

        return result;
    }

}
