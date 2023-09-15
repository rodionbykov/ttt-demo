<cfprocessingdirective pageEncoding="utf-8" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>TTT Demo</title>

    <!-- Bootstrap -->
    <link href="vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/bootstrap/dist/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="vendor/jquery-ui/jquery-ui.min.css" rel="stylesheet">
    <link href="vendor/jquery-ui/jquery-ui.theme.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="vendor/jquery/dist/jquery.min.js"></script>
    <script src="vendor/jquery-ui/jquery-ui.min.js"></script>
    <script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="assets/js/navscroll.js"></script>
    <script src="vendor/moment.min.js"></script>
    <script src="vendor/moment-duration-format.js"></script>

    <!--- Application --->
    <link href="assets/styles/main.css" rel="stylesheet">

</head>
<body>
    <div class="wrapper">
        <cfoutput>
        <nav class="navbar navbar-inverse navbar-fixed-top nav">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <cfif rc.user.isGranted("UserLoggedIn")>
                        <a class="navbar-brand text-uppercase" href="#APPLICATION.demoURL#/index.cfm?do=home.dashboard">ttt</a>
                    <cfelse>
                        <a class="navbar-brand text-uppercase" href="#APPLICATION.demoURL#">ttt</a>
                    </cfif>
                    <span class="nav navbar-nav navbar-text">[&beta;]</span>
                    <span id="calltext" class="nav navbar-nav navbar-text" style="color: red;" data-placement="bottom" title=""></span>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="navigation">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a id="link1" class="nav-about" href="index.cfm?do=home.faq">F.A.Q.</a></li>
                        <cfif rc.user.isGranted("UserLoggedIn")>
                            <li><a id="link3" class="nav-projects" href="index.cfm?do=projects.list">Projects</a></li>
                            <li><a id="link4" class="nav-tasks" href="index.cfm?do=tasks.list">Tasks</a></li>
                            <li><a id="link5" class="nav-activities" href="index.cfm?do=activities.list">Activities</a></li>
                            <li class="dropdown">
                                <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Reports <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="index.cfm?do=reports.timelog">Timelog</a></li>
                                    <li><a href="index.cfm?do=reports.activity">Activity</a></li>
                                    <li><a href="index.cfm?do=reports.summary">Summary</a></li>
                                </ul>
                            </li>
                            <li class="scrollTop"><a href="##"></a></li>
                        </cfif>
                        <cfif rc.user.isGranted("UserLoggedIn")>
                            <li><form action="index.cfm"><input type="hidden" name="do" value="users.logout" /><button type="submit" class="btn btn-success navbar-btn btn-circle">Sign out</button></form></li>
                        <cfelse>
                            <li><form action="index.cfm"><input type="hidden" name="do" value="home.login" /><button type="submit" class="btn btn-success navbar-btn btn-circle">Sign in</button></form></li>
                        </cfif>
                    </ul>
                </div>
            </div>
        </nav>
        </cfoutput>

        <cfoutput>#body#</cfoutput>

        <footer class="footer text-center">
            <div class="container">
                <small>&copy; Copyright 2013 <a href="https://rodyonbykov.com">Rodyon Bykov</a>.</small> <cfoutput><span style="color: ##eee;">#rc.metrics.api#ms</span></cfoutput>
            </div>
        </footer>
    </div>
    <cfif rc.user.isGranted("UserLoggedIn")>
        <script type="text/javascript">

            var pingObj = {};
            var dur = 0;

            function ajax() {
                return $.ajax({
                    <cfoutput>
                    url: '#REQUEST.context.serviceURL#/users/ping/',
                    </cfoutput>
                    type: 'GET',
                    dataType: 'json',
                    beforeSend: setHeader
                });
            }

            function setHeader(xhr) {
                <cfoutput>
                xhr.setRequestHeader('Authorization', 'Bearer #rc.user.getSessionToken()#');
                </cfoutput>
            }

            function ping(){
                ajax().done(function(result) {

                    console.log("success");
                    console.log(result);
                    pingObj = result;
                    dur = moment.duration(pingObj.activity.duration, 'seconds');

                    $("#calltext").show();

                }).fail(function() {
                    console.log("fail");
                    $("#calltext").hide();
                });

                var t = setTimeout(ping, 120000);
            }

            function pingTime() {

                var activitytext = "";
                $("#calltext").html("")

                if(pingObj.activity !== undefined){
                    var sec1 = moment.duration(1, 'seconds');
                    dur.add(sec1);
                    activitytext = dur.format("h[h]mm:ss");

                    $("#calltext").attr("title", pingObj.activity.description);
                    if(pingObj.activity.task !== undefined){
                        $("#calltext").attr("title", "[" + pingObj.activity.task.title + "] " + pingObj.activity.description);
                    }
                    $("#calltext").tooltip();

                    $("#calltext").html("&#9679 " + activitytext);
                    $("#duration").html(activitytext);
                }
            }

            $( document ).ready(function() {
                console.log( "ready!" );
                ping();
                var t = setInterval(pingTime, 1000);
            });

        </script>
    </cfif>
</body><!-- Design crafted with love by @maridlcrmn -->
</html>