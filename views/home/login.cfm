<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>
<header id="about" class="header">
    <div class="container">
        <div class="row">
            
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
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <form class="form-signin" action="index.cfm?do=users.login" method="post">
                    <h2 class="form-signin-heading">Please sign in</h2>
                    <label for="inputEmail" class="sr-only">Email address</label>
                    <input type="text" id="inputLogin" name="login" class="form-control" placeholder="Email address" required autofocus>
                    <label for="inputPassword" class="sr-only">Password</label>
                    <input type="password" id="inputPassword" name="passwd" class="form-control" placeholder="Password" required>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                </form>
            </div>
            <div class="col-md-3"></div>
        </div>
    </div>
</header>
</cfoutput>