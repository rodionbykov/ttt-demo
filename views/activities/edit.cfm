<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>Edit Activity #rc.structActivity.id#</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=activities.save" method="post">
                <input type="hidden" name="id" value="#rc.structActivity.id#" />
                <fieldset class="form-group">
                    <label for="taskID">Task</label>
                    <select class="form-control" id="taskID" name="taskID">
                        <option value="">-- Please select --</option>
                        <cfloop array="#rc.arrTasks#" index="t">
                            <option value="#t.id#" <cfif StructKeyExists(rc.structActivity, "task") AND rc.structActivity.task.id EQ t.id>selected</cfif>>#t.title#</option>
                        </cfloop>
                    </select>
                </fieldset>
                <fieldset class="form-group">
                    <label for="activityDescription">Description</label>
                    <textarea id="activityDescription" class="form-control" name="activityDescription">#htmlEditFormat(rc.structActivity.description)#</textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
        <div class="row">
            <form action="index.cfm?do=activities.remove" method="post">
                <input type="hidden" name="id" value="#rc.structActivity.id#" />
                <button type="submit" class="btn btn-danger pull-right">Remove</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
