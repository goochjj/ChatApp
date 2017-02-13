<html>
    <head>
        <title>ChatApp</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <script>
            window.clientId = <cfoutput>'#CreateUUID()#'</cfoutput>;
            $(function() {
                $("#hello").html("Hello, "+window.clientId);
 
            });
            if (!!window.EventSource)
            {
                var source = new EventSource('messages.cfm?ClientID='+window.clientId);
                source.onmessage = function(event)
                {
                    document.getElementById("chatstream").innerHTML += event.data + "<br>";
                };
            }
            else
            {
                // Result to xhr polling :(
            }

            source.addEventListener('message', function(e) {
                console.log(e.data);
            }, false);

            source.addEventListener('open', function(e) {
                // Connection was opened.
                console.log('Open');
            }, false);

            source.addEventListener('error', function(e) {
                console.log('Error');
                console.log(e);
                //source.close();
                if (e.readyState == EventSource.CLOSED) {
                    // Connection was closed.
                    console.log('Closed');
                }
            }, false);

            function sendMsg(room, msg) {
                $.post("sendmsg.cfm", { room: room, message: msg, ClientID: window.clientId }, function( data ) {
                  $( "#result" ).html( data );
                });
            }
        </script>

    </head>
    <body>
        App. <br/>
        <div id="hello"></div>

        <form id="sendmessage" onsubmit="return false;">
            <textarea name="message"></textarea>
            <button onclick="sendMsg('general', this.form.message.value);">Send</button>
        </form>

        <div id="result"></div>

        <div id="chatstream"></div>


    </body>
</html>
