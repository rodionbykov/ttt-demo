<script type="text/javascript" src="assets/js/bootstrap-wysiwyg.js"></script>
<script>
    $(document).ready( function() {
        $('#taskDescription').wysiwyg();
    });

</script>
<style>
    #taskDescription {overflow:scroll; max-height:300px; height: 300px}
</style>

<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Edit Project</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=projects.save" method="post">
                <input type="hidden" name="id" value="#rc.project.id#" />
                <fieldset class="form-group">
                    <label for="projectName">Name</label>
                    <input type="text" class="form-control" id="projectName" name="projectName" value="#HTMLEditFormat(rc.project.name)#">
                </fieldset>
                <fieldset class="form-group">
                    <label for="projectDescription">Description</label>
                    <textarea id="projectDescription" class="form-control" name="projectDescription">#HTMLEditFormat(rc.project.description)#</textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <div class="row">
            <form action="index.cfm?do=projects.remove" method="post">
                <input type="hidden" name="id" value="#rc.project.id#" />
                <button type="submit" class="btn btn-danger pull-right">Remove</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
