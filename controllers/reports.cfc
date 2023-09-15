component {

    function init(fw)
    {
        VARIABLES.framework = fw;
        return THIS;
    }

    function setBeanFactory(beanFactory)
    {
        VARIABLES.beanFactory = beanFactory;
    }

    public void function before()
    {
        //rc.user = VARIABLES.beanFactory.getBean("User");
        param name ="rc.messages" default=[];
        param name ="rc.errors" default=[];
    }

    public void function timelog(rc)
    {
        param name="rc.from" default="#DateFormat(DateAdd("d", -7, Now()), 'yyyy-mm-dd')#";
        param name="rc.to" default="#DateFormat(Now(), 'yyyy-mm-dd')#";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/reports/timelog/&from=#rc.from#&to=#rc.to#" method="get" result="jsonReport" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

		rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrReport = DeserializeJSON(jsonReport.filecontent);

        rc.qryReport = arrayOfStructuresToQuery(rc.arrReport);
    }

    public void function activity(rc)
    {
        param name="rc.from" default="#DateFormat(DateAdd("d", -7, Now()), 'yyyy-mm-dd')#";
        param name="rc.to" default="#DateFormat(Now(), 'yyyy-mm-dd')#";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/reports/activity/&from=#rc.from#&to=#rc.to#" method="get" result="jsonReport" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrReport = DeserializeJSON(jsonReport.filecontent);

        rc.qryReport = arrayOfStructuresToQuery(rc.arrReport);
    }

    public void function summary(rc)
    {
        param name="rc.from" default="#DateFormat(DateAdd("d", -7, Now()), 'yyyy-mm-dd')#";
        param name="rc.to" default="#DateFormat(Now(), 'yyyy-mm-dd')#";

		var timing = GetTickCount();

        http url="#rc.serviceURL#/reports/summary/&from=#rc.from#&to=#rc.to#" method="get" result="jsonReport" proxyserver="#APPLICATION.proxyServer#" proxyport="#APPLICATION.proxyPort#" {
            httpparam type="header" name="Authorization" value="Bearer #rc.user.getSessionToken()#";
        }

        rc.metrics.api = GetTickCount() - LOCAL.timing;

        rc.arrReport = DeserializeJSON(jsonReport.filecontent);

        rc.qryReport = arrayOfStructuresToQuery(rc.arrReport);
    }

    /**
     * Converts an array of structures to a CF Query Object.
     * 6-19-02: Minor revision by Rob Brooks-Bilson (rbils@amkor.com)
     *
     * Update to handle empty array passed in. Mod by Nathan Dintenfass. Also no longer using list func.
     *
     * @param Array 	 The array of structures to be converted to a query object.  Assumes each array element contains structure with same  (Required)
     * @return Returns a query object.
     * @author David Crawford (dcrawford@acteksoft.com)
     * @version 2, March 19, 2003
     */
    function arrayOfStructuresToQuery(theArray){
        var colNames = "";
        var theQuery = queryNew("");
        var i=0;
        var j=0;
        //if there's nothing in the array, return the empty query
        if(NOT arrayLen(theArray))
            return theQuery;
            //get the column names into an array =
        colNames = structKeyArray(theArray[1]);
        //build the query based on the colNames
        theQuery = queryNew(arrayToList(colNames));
        //add the right number of rows to the query
        queryAddRow(theQuery, arrayLen(theArray));
        //for each element in the array, loop through the columns, populating the query
        for(i=1; i LTE arrayLen(theArray); i=i+1){
            for(j=1; j LTE arrayLen(colNames); j=j+1){
                querySetCell(theQuery, colNames[j], theArray[i][colNames[j]], i);
            }
        }
        return theQuery;
    }
}