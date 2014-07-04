#<%= projectName %>
<% if (addStatusToReadme) { %>

[![Build Status](https://secure.travis-ci.org/<%= gitAccount %>/<%= projectName %>.png?branch=master)](https://travis-ci.org/<%= gitAccount %>/<%= projectName %>)
[![Coverage Status](https://coveralls.io/repos/<%= gitAccount %>/<%= projectName %>/badge.png?branch=master)](https://coveralls.io/r/<%= gitAccount %>/<%= projectName %>?branch=master)
[![npm module](https://badge.fury.io/js/<%= projectName %>.svg)](http://badge.fury.io/js/<%= projectName %>)
[![Node Dependencies](https://david-dm.org/<%= gitAccount %>/<%= projectName %>.png)](https://david-dm.org/<%= gitAccount %>/<%= projectName %>)
[![Node devDependency Status](https://david-dm.org/<%= gitAccount %>/<%= projectName %>/dev-status.png)](https://david-dm.org/<%= gitAccount %>/<%= projectName %>#info=devDependencies)<% } %>
