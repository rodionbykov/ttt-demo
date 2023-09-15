<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        
        <div class="row">
            <h2>Dashboard</h2>
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
        </div>

    </div>
</section>

<section id="features" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="pull-middle">
                    <h2 class="h1 page-header">#rc.user.getFirstName()# #rc.user.getLastName()#</h2>
                    <ul class="media-list">
                        <li class="media">
                            #rc.user.getEmail()#
                        </li>                            
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="content">
                    <cfif IsDefined("rc.structPing.activity")>
                        <h2>Currently running</h2>
                        <cfif IsDefined("rc.structPing.activity.task")>
                            <h3>Task</h3>
                            <p>
                                <a href="index.cfm?do=tasks.view&amp;id=#rc.structPing.activity.task.id#">#HTMLEditFormat(rc.structPing.activity.task.title)#</a>
                            </p>
                        </cfif>
                            <h3>Activity</h3>
                            <p>
                                <a href="index.cfm?do=activities.view&amp;id=#rc.structPing.activity.id#">#HTMLEditFormat(rc.structPing.activity.description)#</a>
                            </p>
                    </cfif>
                </div>
            </div>
            <cfif IsDefined("rc.structPing.activity")>
                <div class="col-md-2">
                    <div class="content">
                    <h3>Duration</h3>
                    <h4 id="duration">
                        #convertSecondsToTimeString(rc.structPing.activity.duration)#
                    </h4>
                    <p>
                        <a href="index.cfm?do=activities.toggle&amp;id=#rc.structPing.activity.id#" class="btn btn-danger">Stop</a>
                    </p>
                    </div>
                </div>
            </cfif>
        </div>
    </div>
</section>

<hr />

</cfoutput>

<cfscript>

    function convertSecondsToTimeString(seconds) {
        local.hours = arguments.seconds \ 3600;
        local.minutes = (arguments.seconds \ 60) mod 60;
        local.seconds = (arguments.seconds) mod 60;
        return numberformat(local.hours, "0") & "h" & numberformat(local.minutes, "00") & "m";
    }

</cfscript>