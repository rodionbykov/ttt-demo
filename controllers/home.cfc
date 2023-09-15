component {

    public void function init(fw) {
        VARIABLES.fw = ARGUMENTS.fw;
    }

    public void function before(){
        param name="rc.messages" default=[];
        param name="rc.errors" default=[];
    }

    public void function dashboard(rc){

        var timing = GetTickCount();

        http url="#rc.serviceURL#/users/ping/" method="get" result="jsonPing" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.structPing = DeserializeJSON(jsonPing.filecontent);
    }

}