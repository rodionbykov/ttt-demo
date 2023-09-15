<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Tasks
                <span class="btn-group">
                    <a href="index.cfm?do=tasks.new" id="btnNewProject" class="btn btn-primary">New Task</a>
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
                        <form action="index.cfm?do=tasks.quickstart" method="post">
                            <td colspan="2">
                                <input type="text" class="form-control" name="title" value="" placeholder="Type new task title here..." />
                            </td>
                            <td colspan="3">
                                <input type="text" class="form-control" name="description" value="" placeholder="Type new activity description here..." />
                            </td>
                            <td>
                                <button type="submit" class="btn btn-primary">Quick Start</button>
                            </td>
                        </form>
                    </tr>
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
                    <cfloop array="#rc.arrTasks#" index="t">
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