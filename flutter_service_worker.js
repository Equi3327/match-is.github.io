'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f393d3c16b631f36852323de8e583132",
"main.dart.js": "b1ae63b489648f4791438eedc7de1b91",
"assets/FontManifest.json": "806f6b30fc84741899cf1b932dbce0fd",
"assets/AssetManifest.bin": "ee165d45e28e0419e7eea42ee6a1eab7",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/assets/sfx/yay1.mp3": "8d3b940e33ccfec612d06a41ae616f71",
"assets/assets/sfx/hash2.mp3": "d26cb7676c3c0d13a78799b3ccac4103",
"assets/assets/sfx/p2.mp3": "ab829255f1ef20fbd4340a7c9e5157ad",
"assets/assets/sfx/fwfwfwfw1.mp3": "d0f7ee0256d1f0d40d77a1264f23342b",
"assets/assets/sfx/k1.mp3": "37ffb6f8c0435298b0a02e4e302e5b1f",
"assets/assets/sfx/sh1.mp3": "f695db540ae0ea850ecbb341a825a47b",
"assets/assets/sfx/spsh1.mp3": "2e1354f39a5988afabb2fdd27cba63e1",
"assets/assets/sfx/fwfwfwfwfw1.mp3": "46355605b43594b67a39170f89141dc1",
"assets/assets/sfx/hh1.mp3": "fab21158730b078ce90568ce2055db07",
"assets/assets/sfx/lalala1.mp3": "b0b85bf59814b014ff48d6d79275ecfd",
"assets/assets/sfx/p1.mp3": "ad28c0d29ac9e8adf9a91a46bfbfac82",
"assets/assets/sfx/kss1.mp3": "fd0664b62bb9205c1ba6868d2d185897",
"assets/assets/sfx/swishswish1.mp3": "219b0f5c2deec2eda0a9e0e941894cb6",
"assets/assets/sfx/README.md": "33033a0943d1325f78116fcf4b8a96ec",
"assets/assets/sfx/wehee1.mp3": "5a986231104c9f084104e5ee1c564bc4",
"assets/assets/sfx/oo1.mp3": "94b9149911d0f2de8f3880c524b93683",
"assets/assets/sfx/wssh1.mp3": "cf92e8d8483097569e3278c82ac9f871",
"assets/assets/sfx/ehehee1.mp3": "52f5042736fa3f4d4198b97fe50ce7f3",
"assets/assets/sfx/haw1.mp3": "00db66b69283acb63a887136dfe7a73c",
"assets/assets/sfx/hash1.mp3": "f444469cd7a5a27062580ecd2b481770",
"assets/assets/sfx/sh2.mp3": "e3212b9a7d1456ecda26fdc263ddd3d0",
"assets/assets/sfx/k2.mp3": "8ec44723c33a1e41f9a96d6bbecde6b9",
"assets/assets/sfx/wssh2.mp3": "255c455d9692c697400696cbb28511cc",
"assets/assets/sfx/hh2.mp3": "4d39e7365b89c74db536c32dfe35580b",
"assets/assets/sfx/dsht1.mp3": "c99ece72f0957a9eaf52ade494465946",
"assets/assets/sfx/hash3.mp3": "38aad045fbbf951bf5e4ca882b56245e",
"assets/assets/sfx/ws1.mp3": "5cfa8fda1ee940e65a19391ddef4d477",
"assets/assets/sfx/kch1.mp3": "a832ed0c8798b4ec95c929a5b0cabd3f",
"assets/assets/game_assets/card_background_7.png": "0c6fd186633a73fca188a26b48319386",
"assets/assets/game_assets/card_background_5.png": "bab9af258d7203ace022e0ab5205c5c4",
"assets/assets/game_assets/card_background_10.png": "9f746cbb1050e706c1297bcf18d6bec6",
"assets/assets/game_assets/card_background_6.png": "f7634d04af6bdb193eb07fd47ff7245d",
"assets/assets/game_assets/heart.png": "710c8ef81fa5dedd218926fdf809848f",
"assets/assets/game_assets/card_background_1.png": "a4d5e7f20bdef51af7b4c8df398a3e03",
"assets/assets/game_assets/diamond.png": "4f7f9ee5f73c60759524c1967901091a",
"assets/assets/game_assets/card_background_3.png": "66da618303b099f8202e6c57f2632a3a",
"assets/assets/game_assets/card_background_8.png": "a682c5918d7d98904aba0ca8dfb17e0c",
"assets/assets/game_assets/card_background_2.png": "f0ddabfc78b2538cb975b24b056d4e44",
"assets/assets/game_assets/card_background_9.png": "c60fe0973227e39bf4fc30f13688a788",
"assets/assets/game_assets/card_background.png": "2d15aefa20d962eb6e1fb4bdda10481f",
"assets/assets/game_assets/card_background_4.png": "b52954ec65928784277fe589590df007",
"assets/assets/game_assets/no_cards.png": "09c87126f81fb7b187a94ae51058c37d",
"assets/assets/game_assets/spade.png": "c91b6429d04d08d2bd44894fd6b24c6d",
"assets/assets/game_assets/club.png": "74521f908e7cd4cb0ffdd97f2e26fbd6",
"assets/assets/fonts/Permanent_Marker/PermanentMarker-Regular.ttf": "c863f8028c2505f92540e0ba7c379002",
"assets/assets/images/3.5x/settings.png": "c977a1e6c59e8cfd5cd88a0c973928fc",
"assets/assets/images/3.5x/back.png": "85db134e26410547037485447f659277",
"assets/assets/images/3.5x/restart.png": "583169ac365d9515fc12f29e3b530de0",
"assets/assets/images/settings.png": "840fd7e3337c743046bf992ef18a10b8",
"assets/assets/images/2x/settings.png": "8404e18c68ba99ca0b181bd96ace0376",
"assets/assets/images/2x/back.png": "85cda8f41a13153d6f3fb1c403f272ea",
"assets/assets/images/2x/restart.png": "83aea4677055df9b0d8171f5315f2a60",
"assets/assets/images/back.png": "3c82301693d5c4140786184a06c23f7e",
"assets/assets/images/restart.png": "d3d2e3f3b2f6cb1e1a69b8b2529096f7",
"assets/assets/images/3x/settings.png": "21ff2cc135a762f74ed1a80aac6502bb",
"assets/assets/images/3x/back.png": "88a977a654df5a490037340f90a5a19e",
"assets/assets/images/3x/restart.png": "429270ce832c881b80fbd592e5ff1e0e",
"assets/assets/music/Mr_Smith-Sunday_Solitude.mp3": "5fb1f2fbf4314eb5df35b62706942698",
"assets/assets/music/Mr_Smith-Sonorus.mp3": "9353b7bb732002062e2c9107a95f3d2a",
"assets/assets/music/README.md": "c2691814a6b5077a5d1e16b86f9ad6e3",
"assets/assets/music/Mr_Smith-Azul.mp3": "9463595498dc48b3d3d6805fb7c19dc7",
"assets/NOTICES": "8b3b47116a204bc191a56fdd675cc1e2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "5668e5888883a0b86a9df6a76b32b0e4",
"assets/AssetManifest.bin.json": "7602fbf33f99bd3fa6e56038b743d6c8",
"index.html": "ef2e2b854a104863c1048c3ab7e5bcb0",
"/": "ef2e2b854a104863c1048c3ab7e5bcb0",
"manifest.json": "d4928ce4c9c29bd41189ce75c54223ec",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "74f808885004a0ba0d5f5e21b048ef0d",
"icons/Icon-192.png": "74f808885004a0ba0d5f5e21b048ef0d",
"icons/Icon-512.png": "540f01201e3c4ab3c822f92275ee037a",
"icons/Icon-maskable-512.png": "540f01201e3c4ab3c822f92275ee037a",
"favicon.png": "7ce2442c15f44c8c4c418ec5d77dd000",
"version.json": "1a61905fe59e8d74c0b5db7477dfb6af",
"flutter_bootstrap.js": "6799731e6c3824ac33627edb9b53ae9b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
