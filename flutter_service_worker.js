'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "99650c617232b1d379c5dd499c9aa312",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/LICENSE": "4426731c49e93bbddd9b2298e8b2c21b",
"assets/images/trump-cartoon.svg": "9e5aa4cff72c0846efda836463206c0f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/AssetManifest.json": "bddc20e7f0ce03e8781803e0b714c890",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "720e6fdb170d19d6f8bb6de043796253",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"index.html": "d51dedb7f54b2dc7e8bf8e4c51e39763",
"/": "d51dedb7f54b2dc7e8bf8e4c51e39763"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
