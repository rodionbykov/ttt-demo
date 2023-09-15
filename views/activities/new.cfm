<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>New Activity</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=activities.add" method="post">
                <fieldset class="form-group">
                    <label for="taskID">Task</label>
                    <select class="form-control" id="taskID" name="taskID">
                        <option value="">-- Please select --</option>
                        <cfloop array="#rc.arrTasks#" index="t">
                            <option value="#t.id#">#t.title#</option>
                        </cfloop>
                    </select>
                </fieldset>
                <fieldset class="form-group">
                    <label for="activityDescription">Description</label>
                    <textarea id="activityDescription" class="form-control" name="activityDescription"></textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Add</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
