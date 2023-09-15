<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Task #rc.structTask.id#</h2>
        </div>
        <div class="row">
            <div class="col-md-8">
                <h3>#rc.structTask.title#</h3>
            </div>
            <div class="col-md-4">
                <h4>#convertSecondsToTimeString(rc.structTask.duration)#</h4>
            </div>
        </div>
        <div class="row">
            <div>
                <p>#rc.structTask.description#</p>
            </div>
        </div>
        <form action="index.cfm?do=tasks.quickstartactivity" method="post">
        <input type="hidden" name="taskid" value="#rc.structTask.id#" />
        <div class="row">
            <div class="col-md-10">
                <input type="text" class="form-control" name="description" value="" placeholder="Type new activity description here..." />
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary">Quick Start</button>
            </div>
        </div>
        </form>
        <cfif StructKeyExists(rc.structTask, "activities")>
        <div class="row">
            <h4>Activities</h4>
            <table class="table table-condensed table-hover">
                <thead>
                    <tr>
                        <td>ID</td>
                        <td>Description</td>
                        <td>Started</td>
                        <td>Stopped</td>
                        <td>Last action</td>
                        <td>Duration</td>
                        <td>Running</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                    <cfloop array="#rc.structTask.activities#" index="a">
                    <tr>
                        <td>#a.id#</td>
                        <td><a href="index.cfm?do=activities.view&amp;id=#a.id#">#a.description#</a></td>
                        <td>#DateTimeFormat(ParseDateTime(a.started), "long")#</td>
                        <td>
                            <cfif StructKeyExists(a, "stopped") AND Len(a.stopped) GT 0>
                            #DateTimeFormat(ParseDateTime(a.stopped), "long")#
                            </cfif>
                        </td>
                        <td>#DateTimeFormat(ParseDateTime(a.moment), "long")#</td>
                        <td><span id="duration">#ConvertSecondsToTimeString(a.duration)#</span></td>
                        <td>#YesNoFormat(a.isrunning)#</td>
                        <td>
                            <form action="index.cfm?do=tasks.toggleactivity" method="post">
                                <input type="hidden" name="id" value="#a.id#"/ >
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
        </cfif>
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