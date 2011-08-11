---
authors:
- name: Thomas Sawyer
  email: transfire@gmail.com
copyrights:
- holder: Thomas Sawyer
  year: '2011'
  license: BSD-2-Clause
replacements: []
conflicts: []
requirements:
- name: test
- name: ae
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
dependencies: []
repositories:
- uri: git://github.com/proutils/lime.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/lime
  code: http://github.com/rubyworks/lime
  mail: http://groups.google.com/group/rubyworks-mailinglist
load_path:
- lib
extra:
  manifest: MANIFEST
alternatives: []
revision: 0
title: Lime
suite: RubyWorks
summary: Gherkin-style Test Framework
description: Lime is a pure Ruby variation of Cucumber's Gherkin BDD test system that
  runs on top of the Ruby Universal Test Harness.
version: 0.2.0
name: lime
date: '2011-08-11'
