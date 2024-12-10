fetch('http://localhost:8080', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/twitch-api',
    },
    body: document.location.hash.length == 0 ? document.location.search : document.location.hash
})

.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('Error:', error));