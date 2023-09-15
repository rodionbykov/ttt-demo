<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Activity #rc.structActivity.id#</h2>
        </div>
        <div class="row">
            <div class="col-md-6">
                <h3>#rc.structActivity.description#</h3>
            </div>
            <div class="col-md-4">
                <h4><span id="duration">#convertSecondsToTimeString(rc.structActivity.duration)#</span></h4>
            </div>
            <div class="col-md-2">
                <form action="index.cfm?do=activities.toggle" method="post">
                    <input type="hidden" name="id" value="#rc.structActivity.id#"/ >
                    <cfif rc.structActivity.isrunning>
                            <button type="submit" class="btn btn-danger">Stop</button>
                    <cfelse>
                            <button type="submit" class="btn btn-success">Start</button>
                    </cfif>
                </form>
            </div>
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