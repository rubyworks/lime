---
source:
- meta
authors:
- name: Trans
  email: transfire@gmail.com
copyrights:
- holder: Rubyworks
  year: '2011'
  license: BSD-2-Clause
requirements:
- name: rubytest
- name: detroit
  groups:
  - build
  development: true
- name: reap
  groups:
  - build
  development: true
- name: qed
  groups:
  - test
  development: true
- name: ae
  groups:
  - test
  development: true
dependencies: []
alternatives: []
conflicts: []
repositories:
- uri: git://github.com/proutils/lime.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/lime
  code: http://github.com/rubyworks/lime
  bugs: http://github.com/rubyworks/lime/issues
  mail: http://groups.google.com/groups/rubyworks-mailinglist
extra: {}
load_path:
- lib
revision: 0
created: '2011-08-11'
summary: Pure Ruby Gherkin-style Test Framework
title: Lime
version: 0.3.0
name: lime
description: ! 'Lime is a pure Ruby variation of Cucumber''s Gherkin BDD test system

  that runs on top of RubyTest, a Universal Test Harness for Ruby.'
organization: Rubyworks
date: '2012-03-03'
