$(document).ready(function() {
    $('#login-btn').click(function() {
        debugger;

        var email = $('#email').val();
        var password = $('#password').val();
        $.ajax({
            url: '/login',
            type: 'POST',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            data: {
                email: email,
                password: password
            },
            success: function(response) {
                var messageDiv = $('#login-message');
                if (response.status === 'success') {
                    messageDiv.html('<p>Login successful!</p>');
                    // Redirect or perform other actions here
                } else {
                    messageDiv.html('<p>Login failed: ' + response.error + '</p>');
                }
            },
            error: function(xhr) {
                var messageDiv = $('#login-message');
                var response = JSON.parse(xhr.responseText);
                messageDiv.html('<p>Login failed: ' + response.error + '</p>');
            }
        });
    });
});
