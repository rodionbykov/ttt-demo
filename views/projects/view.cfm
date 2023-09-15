<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Project #rc.structProject.id#</h2>
        </div>
        <div class="row">
            <div class="col-md-8">
                <h3>#rc.structProject.name#</h3>
            </div>
            <div class="col-md-4">
                <h4>#convertSecondsToTimeString(rc.structProject.duration)#</h4>
            </div>
        </div>
        <div class="row">
            <div>
                <p>#rc.structProject.description#</p>
            </div>
        </div>
        <form action="index.cfm?do=projects.quickstarttask" method="post">
        <input type="hidden" name="projectid" value="#rc.structProject.id#" />
        <div class="row">
            <div class="col-md-5">
                <input type="text" class="form-control" name="title" value="" placeholder="Type new task title here..." />
            </div>
            <div class="col-md-5">
                <input type="text" class="form-control" name="description" value="" placeholder="Type new activity description here..." />
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-primary">Quick Start</button>
            </div>
        </div>
        </form>
        <div class="row">
            <h4>Tasks</h4>
            <table class="table table-condensed table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Started</th>
                        <th>Last action</th>
                        <th>Running?</th>
                        <th>Duration</th>
                        <td>&nbsp;</td>
                    </tr>
                </thead>
                <tbody>
                    <cfif StructKeyExists(rc.structProject, "tasks")>
                        <cfloop array="#rc.structProject.tasks#" index="t">
                        <tr>
                            <td>#t.id#</td>
                            <td><a href="index.cfm?do=tasks.view&amp;id=#t.id#">#t.title#</a></td>
                            <td>#DateFormat(ParseDateTime(t.created), "long")#</td>
                            <td>#DateTimeFormat(ParseDateTime(t.moment), "long")#</td>
                            <td>
                            #YesNoFormat(t.isrunning)#
                            <cfif t.isrunning>
                                <a href="index.cfm?do=tasks.stop&amp;id=#t.id#" class="btn btn-danger">Stop</a>
                            </cfif>
                            </td>
                            <td>#ConvertSecondsToTimeString(t.duration)#</td>
                            <td><a href="index.cfm?do=tasks.edit&amp;id=#t.id#" class="btn btn-default">Edit</a>
                        </tr>
                        </cfloop>
                    <cfelse>
                        <tr>
                            <td colspan="7">(No tasks yet)</td>
                        </tr>
                    </cfif>
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