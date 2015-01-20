# nconf-strip-json-comments

A tiny module enabling `nconf` to parse commented JSON files.

```javascript
  {
    // User data
    "user": "contact@hoffonline.com", // an email address
    "password": "Freedom",

    // General setup
    "environment": "production",    // or "stage", "development"

    ...
  }
```

Comments in JSON files can be quite helpful, e.g. in configuration files. However, comments are not part of the [JSON format](http://www.json.org), and commented JSON files will e.g. cause exceptions when using `JSON.parse`.
Tools like [jsonminify](https://github.com/fkei/JSON.minify) or [strip-json-comments](https://github.com/sindresorhus/strip-json-comments) allow for parsing of commented JSON files. This module enables the [nconf](https://github.com/flatiron/nconf) module to parse commented JSON files.


## Usage
To enable nconf to parse commented JSON files by default:

```javascript
  var nconf = require('nconf');
  require('nconf-strip-json-comments')(nconf);

  nconf.file('path_to_some_commented_JSON_');
```
Note that this will enable extended parsing _globally_, that is, whereever nconf is required.


Instead, you can also use the format explicitly:
```javascript
  var nconf = require('nconf');
  var commentedJsonFormat = require('nconf-strip-json-comments').format;

  nconf.file({file: 'path_to_some_commented_JSON_', format: commentedJsonFormat});
```

To disable a previously enabled extended parsing, use `restore()`:

```javascript
  ...
  require('nconf-strip-json-comments').restore(nconf);

```


## License
nconf-strip-json-comments is licensed under the [BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause).
