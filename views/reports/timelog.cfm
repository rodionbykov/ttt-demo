<cfoutput>
    <header id="about" class="header">
        <div class="container">

        </div>
    </header>
    <section id="features" class="section">
    <div class="container">
    <div class="row">
        <h2>Timelog</h2>
    <cfif ArrayLen(rc.messages) GT 0>
        <cfloop array="#rc.messages#" index="m">
                <div class="alert alert-success">
                <strong>#m#</strong>
            </div>
        </cfloop>
    </cfif>
    <cfif ArrayLen(rc.errors) GT 0>
        <cfloop array="#rc.errors#" index="m">
                <div class="alert alert-danger">
                <strong>#m#</strong>
            </div>
        </cfloop>
    </cfif>
    <table class="table table-condensed table-hover">
        <thead>
        <tr>
            <form action="index.cfm?do=reports.timelog" method="post">
                <td colspan="2">
                    <div class="input-group date" data-provide="datepicker">
                        <input type="text" class="form-control datepicker" name="from" value="#DateFormat(rc.from, 'YYYY-mm-dd')#" >
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </div>
                    </div>
                </td>
                <td colspan="2">
                    <div class="input-group date" data-provide="datepicker">
                        <input type="text" class="form-control datepicker" name="to" value="#DateFormat(rc.to, 'YYYY-mm-dd')#" >
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </div>
                    </div>
                </td>
                <td colspan="3">
                    <button type="submit" class="btn btn-primary">Report</button>
                </td>
            </form>
        </tr>
        <tr>
            <th>ID</th>
            <th>Activity</th>
            <th>Task</th>
            <th>Project</th>
            <th>Started</th>
            <th>Stopped</th>
            <th>Duration</th>
        </tr>
        </thead>
    <tbody>
    <cfset totalDuration = 0 />
    <!---
    <cfloop array="#rc.arrReport#" index="r">
    --->
    <cfoutput query="rc.qryReport" group="datestarted">
    <cfset subDuration = 0 />
    <tr>
        <td colspan="7"><strong>#DateFormat(ParseDateTime(datestarted), "long")#</strong></td>
    </tr>
    <cfoutput>
    <cfset activity = rc.qryReport.activity[rc.qryReport.CurrentRow] />
    <tr>
        <td>#id#</td>
        <td><a href="index.cfm?do=activities.view&amp;id=#activity.id#">#activity.description#</a></td>
        <td>
            <cfif StructKeyExists(activity, "task")>
                <a href="index.cfm?do=tasks.view&amp;id=#activity.task.id#">#activity.task.title#</a>
            <cfelse>
                &nbsp;
            </cfif>
        </td>
        <td>
            <cfif StructKeyExists(activity, "task") AND StructKeyExists(activity.task, "project")>
                <a href="index.cfm?do=projects.view&amp;id=#activity.task.project.id#">#activity.task.project.name#</a>
            <cfelse>
                    &nbsp;
            </cfif>
        </td>
        <td>#DateTimeFormat(ParseDateTime(started), "long")#</td>
        <td>#DateTimeFormat(ParseDateTime(stopped), "long")#</td>
        <td>#ConvertSecondsToTimeString(duration)#</td>
    </tr>
        <cfset totalDuration = totalDuration + duration />
        <cfset subDuration = subDuration + duration />
    </cfoutput>
        <tr>
            <td colspan="6" style="text-align: right;">
                <em>Day Total time</em>
            </td>
            <td><em>#ConvertSecondsToTimeString(subDuration)#</em></td>
        </tr>
    </cfoutput>
        <tr>
            <td colspan="6" style="text-align: right;">
                <strong>Total time</strong>
            </td>
            <td><strong>#ConvertSecondsToTimeString(totalDuration)#</strong></td>
        </tr>
    </tbody>
    </table>
    </div>
    </div>
    </section>
</cfoutput>

<cfscript>

    function convertSecondsToTimeString(seconds) {
        local.hours = arguments.seconds \ 3600;
        local.minutes = (arguments.seconds \ 60) mod 60;
        local.seconds = (arguments.seconds) mod 60;
    return numberformat(local.hours, "0") & "h" & numberformat(local.minutes, "00") & "m";
}

</cfscript>

<script>
    $( function() {
        $( ".datepicker" ).datepicker( {
            dateFormat: "yy-mm-dd"
        } );
    } );
</script>