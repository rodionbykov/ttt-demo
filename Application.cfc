component extends="vendor.fw1.framework.one" {

    THIS.name = "tttdemo" & hash(getCurrentTemplatePath());
    THIS.sessionManagement = "true";
    THIS.sessionTimeout = CreateTimeSpan( 0, 8, 0, 0 );
    this.mappings['/framework'] = getDirectoryFromPath(getCurrentTemplatePath()) & "/vendor/fw1/framework/";

    VARIABLES.framework = structNew();
    VARIABLES.framework.action = "do";
    VARIABLES.framework.usingSubsystems = false;
    VARIABLES.framework.defaultSection = "home";
    VARIABLES.framework.defaultItem = "welcome";
    VARIABLES.framework.reloadApplicationOnEveryRequest = false;
    VARIABLES.diLocations = "/model,/controllers";

    function setupApplication(){
        APPLICATION.demoURL = "http://demo.ttt";
        APPLICATION.serviceURL = "http://api.ttt";
        APPLICATION.proxyServer = "";
        APPLICATION.proxyPort = "0";
    }

    function setupRequest(){
        REQUEST.context.subscriberAccessKey = "00001-almagro";
        REQUEST.context.subscriberSecret = "F9A08BA54DA9672B91B399487C07BF411F65C8D6F1C54";
        REQUEST.context.serviceURL = APPLICATION.serviceURL & "/v1/s-" & REQUEST.context.subscriberAccessKey;
        REQUEST.context.user = THIS.getBeanFactory().getBean("User");
        if(IsDefined("SESSION.user")){
            REQUEST.context.user = SESSION.user;
        }
        REQUEST.context.metrics = {};
        REQUEST.context.metrics.api = 0;
    }

}
