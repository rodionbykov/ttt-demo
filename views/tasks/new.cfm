<cfoutput>
<header id="about" class="header">
    <div class="container">

    </div>
</header>
<section id="features" class="section">
    <div class="container">
        <div class="row">
            <h2>New Task</h2>
        </div>
        <div class="row">
            <form action="index.cfm?do=tasks.add" method="post">
                <fieldset class="form-group">
                    <label for="taskTitle">Title *</label>
                    <input type="text" class="form-control" id="taskTitle" name="taskTitle" placeholder="Type in task name">
                </fieldset>
                <fieldset class="form-group">
                    <label for="taskTitle">Project</label>
                    <select class="form-control" id="taskProjectID" name="taskProjectID">
                        <option value="">-- Please select --</option>
                        <cfloop array="#rc.arrProjects#" index="p">
                        <option value="#p.id#">#p.name#</option>
                        </cfloop>
                    </select>
                </fieldset>
                <fieldset class="form-group">
                    <label for="taskDescription">Description</label>
                    <textarea id="taskDescription" class="form-control" name="taskDescription"></textarea>
                </fieldset>
                <button type="submit" class="btn btn-primary">Add</button>
            </form>
        </div>
    </div>
</section>

<hr />
</cfoutput>
