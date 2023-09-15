<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>New Project</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=projects.add" method="post">
                <fieldset class="form-group">
                    <label for="projectName">Name</label>
                    <input type="text" class="form-control" id="projectName" name="projectName" placeholder="Type in project name">
                </fieldset>
                <fieldset class="form-group">
                    <label for="projectDescription">Description</label>
                    <textarea id="projectDescription" class="form-control" name="projectDescription"></textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Add</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
