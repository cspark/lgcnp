

console.log('Started', self);
self.addEventListener('install', function(event) {
  self.skipWaiting();
  console.log('Installed', event);
});
self.addEventListener('activate', function(event) {
  console.log('Activated', event);
});
self.addEventListener('push', function(event) {
  console.log('Push message received!! ', event);
  console.log('Push message received!! ', event.data);
  console.log('Push message received!! ', event.data.json());

  var json = event.data.json();

  // self.registration.showNotification("PLS", {
  //   body: json.alert,
  //   icon: "../img/ic_profile.png"
  // });
  // console.log(event.ports);
  // event.ports[0].postMessage("SW Says 'Hello back!'");
});
self.addEventListener('notificationclick', function(event) {
  console.log('Push message received!! ', event.data.json());
  event.notification.close();

  event.waitUntil(
    clients.matchAll({
      type: "window"
    })
    .then(function(clientList) {
      console.log(clientList);
      for (var i = 0; i < clientList.length; i++) {
        console.log('Push message received!! ', event.data.json());
        var client = clientList[i];
        if (client.url == '/' && 'focus' in client)
          return client.focus();
      }
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    })
  );
});
// curl --header "Authorization: key=AIzaSyBFFqt7Y8Zqqb3UGFs7TItTwZO5yNfBZNQ" --header "Content-Type: application/json" https://android.googleapis.com/gcm/send -d "{\"registration_ids\":[\"dxjs3sOS3Ug:APA91bHcHpd-sLue15io6tvvS1sA2hgpTnF6zBQ_CxT-2SG9z_UWyvseGAimkJ_UHtA3XEAWVHS5pWzyMN3rTuOA77tMFzLt7HZiRmx2mDTLLwfjnkfDlsRocTqLXw1JLipqDj-kNaAh\"]}"
