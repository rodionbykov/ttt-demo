<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Edit Task #rc.structTask.id#</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=tasks.save" method="post">
                <input type="hidden" name="id" value="#rc.structTask.id#" />
                <fieldset class="form-group">
                    <label for="taskTitle">Title *</label>
                    <input type="text" class="form-control" id="taskTitle" name="taskTitle" placeholder="Type in task name" value="#htmlEditFormat(rc.structTask.title)#">
                </fieldset>
                <fieldset class="form-group">
                    <label for="taskTitle">Project</label>
                    <select class="form-control" id="taskProjectID" name="taskProjectID">
                        <option value="">-- Please select --</option>
                        <cfloop array="#rc.arrProjects#" index="p">
                        <option value="#p.id#" <cfif StructKeyExists(rc.structTask, "project") AND rc.structTask.project.id EQ p.id>selected</cfif>>#p.name#</option>
                        </cfloop>
                    </select>
                </fieldset>
                <fieldset class="form-group">
                    <label for="taskDescription">Description</label>
                    <textarea id="taskDescription" class="form-control" name="taskDescription">#htmlEditFormat(rc.structTask.description)#</textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <div class="row">
            <form action="index.cfm?do=tasks.remove" method="post">
                    <input type="hidden" name="id" value="#rc.structTask.id#" />
                <button type="submit" class="btn btn-danger pull-right">Remove</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
