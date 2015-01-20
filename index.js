"use strict";

var nconf = require('nconf');
var stripJsonComments = require('strip-json-comments');

var getCommentedJsonFormat = function(nconfInstance) {
  var nconf = nconfInstance || nconf;
  return {
    parse: function(data) {
      return JSON.parse(stripJsonComments(data));
    },
    stringify: nconf.formats.json.stringify
  }
};

var addCommentedJsonFormat = function(nconfInstance) {
  var format = getCommentedJsonFormat(nconfInstance);
  if (nconfInstance) {
    nconfInstance.formats.__json = nconfInstance.formats.json;
    nconfInstance.formats.json = format;
    return nconfInstance;
  } else {
    return format;
  }
};

var restoreJsonFormat = function(nconfInstance) {
  if (nconfInstance && nconfInstance.formats && nconfInstance.formats.__json) {
    nconfInstance.formats.json = nconfInstance.formats.__json;
  } else {
    // Could not restore JSON format, ignore.
  }
  return nconfInstance;
};

addCommentedJsonFormat.format = getCommentedJsonFormat(nconf);
addCommentedJsonFormat.restore = restoreJsonFormat;

module.exports = addCommentedJsonFormat;
