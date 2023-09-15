<cfoutput>
    <header id="about" class="header">
        <div class="container">

        </div>
    </header>
    <section id="features" class="section">
        <div class="container">
            <div class="row">
                <h2>Activities
                    <span class="btn-group">
                        <a href="index.cfm?do=activities.new" id="btnNewActivity" class="btn btn-primary">New Activity</a>
                    </span>
                </h2>
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
                        <form action="index.cfm?do=activities.quickstart" method="post">
                            <td colspan="8">
                                <input type="text" class="form-control" name="description" value=""
                                       placeholder="Type new activity description here..."/>
                            </td>
                            <td>
                                <button type="submit" class="btn btn-primary">Quick Start</button>
                            </td>
                        </form>
                    </tr>
                    <tr>
                        <th>ID</th>
                        <th>Description</th>
                        <th>Task</th>
                        <th>Started</th>
                        <th>Stopped</th>
                        <th>Last action</th>
                        <th>Duration</th>
                        <th>Running</th>
                        <th>&nbsp;</th>
                        <th>&nbsp;</th>
                    </tr>
                    </thead>
                <tbody>
                <cfloop array="#rc.arrActivities#" index="a">
                    <tr>
                        <td>#a.id#</td>
                        <td><a href="index.cfm?do=activities.view&amp;id=#a.id#">#a.description#</a></td>
                        <td>
                            <cfif StructKeyExists(a, "task")><a href="index.cfm?do=tasks.view&amp;id=#a.task.id#">#a.task.title#</a></cfif>
                        </td>
                    <td>
                    <cfif StructKeyExists(a, "started") AND Len(a.started) GT 0>
                        #DateTimeFormat(ParseDateTime(a.started), "long")#
                    </cfif>
                    </td>
                    <td>
                    <cfif StructKeyExists(a, "stopped") AND Len(a.stopped) GT 0>
                        #DateTimeFormat(ParseDateTime(a.stopped), "long")#
                    </cfif>
                    </td>
                    <td>#DateTimeFormat(ParseDateTime(a.moment), "long")#</td>
                <td><span id="duration">#ConvertSecondsToTimeString(a.duration)#</span></td>
                <td>#YesNoFormat(a.isrunning)#</td>
                <td>
                    <form action="index.cfm?do=activities.toggle" method="post">
                        <input type="hidden" name="id" value="#a.id#" />
                        <cfif a.isrunning>
                            <button type="submit" class="btn btn-danger">Stop</button>
                        <cfelse>
                            <button type="submit" class="btn btn-success">Start</button>
                        </cfif>
                    </form>
                    </td>
                <td>
                    <form action="index.cfm?do=activities.edit" method="post">
                            <input type="hidden" name="id" value="#a.id#" />
                    <button type="submit" class="btn btn-default">Edit</button>
                    </form>
                </td>
                </tr>
                </cfloop>
                </tbody>
                </table>
            </div>
        </div>
    </section>
</cfoutput>

<cfscript>

    function convertSecondsToTimeString(seconds)
    {
        local.hours = arguments.seconds \ 3600;
        local.minutes = (arguments.seconds \ 60) mod 60;
        local.seconds = (arguments.seconds) mod 60;
    return numberformat(local.hours, "0") & "h" & numberformat(local.minutes, "00") & "m";
}

</cfscript>