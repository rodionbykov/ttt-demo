component accessors="true" {

    property name="id";
    property name="login";
    property name="firstname";
    property name="lastname";
    property name="email";
    property name="created";
    property name="moment";
    property name="sessiontoken";
    property name="tokens";

    public any function init(){
        VARIABLES.setID(0);
        VARIABLES.setLogin('');
        VARIABLES.setFirstName('');
        VARIABLES.setLastName('');
        VARIABLES.setEmail('');
        VARIABLES.setCreated(Now());
        VARIABLES.setMoment(Now());
        VARIABLES.setSessionToken('');
        VARIABLES.setTokens(ArrayNew(1));

        return THIS;
    }

    public boolean function isGranted(string token){
        if(ArrayFind(VARIABLES.tokens, ARGUMENTS.token)){
            return true;
        }
        return false;
    }
}