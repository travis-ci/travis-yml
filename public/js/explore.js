window.onload = function() {
  var raw = document.getElementById('yml-raw');
  if (!raw) return;
  var parse = document.getElementById('yml-parse');
  var msgs = document.getElementById('msgs');
  var config = document.getElementById('config');
  var expanded = document.getElementById('yml-expanded');

  var parseSpin = document.getElementById('parse-spin');
  var expandedSpin = document.getElementById('expanded-spin');

  var token = window.token;
  var parseURL = window.parseURL;
  var expandURL = window.expandURL;

  var throttle = function(fn, ms, scope) {
    var wait = false;
    return function() {
      var t = scope || this;
      var a = arguments;
      if (!wait) {
        wait = true;
        setTimeout(function() {
          fn.apply(t, a)
          wait = false;
        }, ms);
      }
    };
  };

  var parseReq = function(yml) {
    fetch(parseURL, {
      method: 'POST',
      headers: { 'Authorization': 'Basic ' + btoa('x:' + token) },
      body: yml
    }).then(parseRender);
  };

  var expandReq = throttle(function(config) {
    fetch(expandURL, {
      method: 'POST',
      headers: { 'Authorization': 'Basic ' + btoa('x:' + token) },
      body: JSON.stringify(config)
    }).then(expandRender);
  }, 500);

  var parseRender = function(response) {
    msgs.innerText = '';
    config.innerText = '';
    expanded.innerText = '';

    if (response.status >= 400) {
      response.json().then(parseError);
    } else {
      response.json().then(parseSuccess);
    }

    parseSpin.classList.remove('spinner');
  };

  var parseError = function(json) {
    parse.classList.add('error');
    config.innerText = json.error_type + ': ' + json.error_message;
  };

  var parseSuccess = function(json) {
    parse.classList.remove('error');
    if (json.full_messages.length > 0) { msgs.innerText = json.full_messages.join('\n\n'); }
    config.innerText = JSON.stringify(json.config, null, '  ');
    expandedSpin.classList.add('spinner');
    expandReq(json.config);
  };

  var expandRender = function(response) {
    if (response.status >= 400) {
      response.json().then(expandError);
    } else {
      response.json().then(expandSuccess);
    }

    expandedSpin.classList.remove('spinner');
  };

  var expandError = function(json) {
    expanded.classList.add('error');
    expanded.innerText = JSON.stringify(json);
  };

  var expandSuccess = function(json) {
    expanded.classList.remove('error');
    expanded.innerText = JSON.stringify(json.matrix, null, '  ');
  };

  raw.addEventListener('input', throttle(function(input) {
    parseSpin.classList.add('spinner');
    parseReq(input.target.innerText);
  }, 500));
};
