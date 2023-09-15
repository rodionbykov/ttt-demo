<cfoutput>
<header id="about" class="header">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="content">
                    <div class="pull-middle">

                      <h2>F.A.Q.</h2>

                      <h3>What is TTT?</h3>
                      <p>TTT is a time/task tracking JSON API. Website you are currently on is a demo-client of TTT JSON API.</p>

                      <h3>What is demo?</h3>
                      <p>Demo is time/task tracking application based on TTT JSON API.</p>

                      <h3>What functions are implemented?</h3>
                      <p>Using this Demo Application you can add/edit/delete Projects and Tasks, track time by starting and stopping Activities.</p>
						          <p>Also you can generate Reports for Day, Task or Project using Reports section.</p>
                      
                      <h3>What objects and functions are available?</h3>
                      <p>Main three objects are Activity, Task and Project.</p>
                      <p>Activity is a main time tracking object. Activities may be linked to Tasks. Tasks can be grouped to Projects. All three objects can be listed, created, edited and deleted.</p>
                      <p>Activity can be started and stopped. API tracks summary time per Activity.</p>

                      <h3>Should I be registered in order to use the API?</h3>
                      <p>Yes, you should have User login and password in order to interact with API. Once logged in, User gets session key which is used with every request.</p>

                      <h3>Why I cannot find Signup or Register page?</h3>
						          <p>API is designed such way that only Subscriber can add new users.</p>

                      <h3>Who are Subscribers?</h3>
                      <p>Subsciber is a company or an individual who has administrative access to API and pays for the service. Subscriber can create unlimited number of Users.</p>

                      <h3>How can I register as User?</h3>
                      <p>You can not. Only Subscribers can create Users using Subscriber's interface.</p>

                      <h3>How service is paid?</h3>
                      <p>Every User interaction with the API is called a 'pass'. Logging in, reading list of Tasks, starting or stopping Activity is a 'pass'. Subscribers buys 'passes' in packages, which are stored with Subscriber's account. Every pass made by User is deducted from Subscriber's account. Packages sold for example can have 10000 passes, which is approximately enough for month of usage for company of 5 people. When Subscriber account goes low on passes count, email notification will be sent, inviting to buy additional package. Once passes count is 0 or less (it's possible to work into some negative pass count), Subscriber and Users registered by Subscriber will not be allowed to do API requests.</p>

                      <h3>What's a Pass ?</h3>
                      <p>Pass is a payment unit.</p>

                      <ul>
                        <li>Each interaction with API costs User 1 Pass</li>
                        <li>Subscriber's account is debited for all User's interactions with the API</li>
                      </ul>

                      <h3>Who's User ?</h3>
                      <p>End-User of TTT API</p>

                      <ul>
                        <li>Actually uses API</li>
                        <li>Has Activities, Tasks, Projects</li>
                        <li>Created and granted access to API by Subscriber</li>
                      </ul>

                      <h3>What can I do when I get Subscriber access?</h3>
                      <p>You can create unlimited number of Users. Then you can use API for time/task tracking. For example you can build your own mobile application or integrate TTT API with corporate systems in order to add time/task tracking capabilities to existing application.</p>

                      <h3>Is there existing tool or app that is using TTT API?</h3>
                      <p>This Demo application is a showcase featuring implementation of the API. This Demo application can be used for actual time/task tracking, but it has only basic features. Main idea is that YOU decide what to do with TTT API, and what application to build around it.</p>

                      <h3>What are building blocks of API ?</h3>
                      <ol>
                        <li>Tidbit: Ti(me) Bit, smallest time interval, user starts and stops tidbits</li>
                        <li>Activity: the work you do, can have many Tidbits, as Activity can be started and stopped</li>
                        <li>Task: bunch of Activities</li>
                        <li>Project: bunch of Tasks or Activities</li>
                      </ol>

                      <h3>I want to build better application! Where can I find API reference?</h3>
                      <p>This Demo is only built to show capabilities of the API, we encourage you to build your own time tracking application using TTT API, or integrate TTT API into existing application.</p>

                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
</cfoutput>