<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Projects
                <span class="btn-group">
                    <a href="index.cfm?do=projects.new" id="btnNewProject" class="btn btn-primary">New Project</a>
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
                        <th>ID</th>
                        <th>Name</th>
                        <th>Started</th>
                        <th>Last action</th>
                        <th>Duration</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop array="#rc.arrProjects#" index="p">
                    <tr>
                        <td>#p.id#</td>
                        <td><a href="index.cfm?do=projects.view&amp;id=#p.id#">#p.name#</a></td>
                        <td>#DateFormat(ParseDateTime(p.created), "long")#</td>
                        <td>#DateTimeFormat(ParseDateTime(p.moment), "long")#</td>
                        <td>#ConvertSecondsToTimeString(p.duration)#</td>
                        <td><a href="index.cfm?do=projects.edit&amp;id=#p.id#" class="btn btn-default">Edit</a>
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