# Dryml FireMarker

Adds DRYML markers viewable with FireMarker (a Firefox/Firebug extension)

## Overview

Dryml FireMarker is a tool composed by 2 components:

1. "FireMarker": a Firebug extension that graphically shows special markers embedded in any HTML page.
2. "dryml-firemarker": a gem to use with Dryml/Hobo that simply marks (with FireMarker markers),
specific parts of HTML with their related metainfo.

## 1. FireMarker (FF extension)

FireMarker is an extension for Firebug that graphically shows special markers embedded in any HTML page. Its main
benefit is that you can easily read the metainfo related to any specific part of the HTML by just hovering the
mouse on the page-item. It also adds a few interactive features to Firebug and an inline file viewer/editor.

### 1.1 Requirements

- Recent Firefox >= 3.6
- Recent Firebug (I use the 1.7.1 but it might work on older versions too)

### 1.2 Installation

Download the latest compiled extension from:

  https://github.com/ddnexus/firemarker/downloads

Install in Firefox with Tools > Add-ons > Install Add-on From File...

## 2. Dryml FireMarker (gem)

Dryml FireMarker is a ruby gem, so you can istall it as usual:

    $ [sudo] gem install dryml-firemarker

Since Dryml is implemented in 3 different ways in Hobo 1.0.x, Dryml 1.1.x and Dryml >= 1.3,
you must setup your app consistently with the dryml version it uses.

### 2.1 Hobo 1.0.x and Hobo/Dryml 1.1.x

#### Setup

In the `environment.rb` file:

    config.gem 'dryml-firemarker', :lib => 'dryml<version>-firemarker'

\<version\> is '10' for Hobo 1.0.x or '11' for Hobo/Dryml 1.1.x

If you use the `rapid` taglib (i.e. Hobo) you have also to add a tag in the `views/auto/taglibs/application.dryml` file:

    <include plugin="dryml-firemarker"/>

Notice that you must add it after the inclusion of the `rapid` taglib.

#### Notes

If your app uses the `rapid` taglib, the gem for the 1.0.x and 1.1.x should be loaded in the regular `environment.rb`
(i.e. not just in `development.rb`), since it fixes a few consolidated bugs coded in that taglib. Besides,
you can safely load it in all environments, because - by default - it will add the matainfo to the page only in
development mode, and will keep the fixes consistent in all environments.

You can also force the inclusion or the skipping of the metainfo in the page, by setting the `DRYML_METAINFO`
boolean constant just before the `config.gem 'dryml-firemarker',...` statement.

If your application needs to override one of `hobo-rapid-javascripts`, `part-contexts-javascripts` or
`page-scripts` helpers/tags, you must take into account that the tags that your application uses are defined in
the `dryml-firemarker.dryml` taglib included in this gem (and not the same tags defined in the regular rapid taglib).

### 2.2. Hobo/Dryml >= 1.3

Add just one line to the `Gemfile` file:

    gem 'dryml-firemarker', :require => 'dryml13-firemarker', :group => :development

There are no bugs to fix in the Hobo/Dryml >= 1.3.0 version, so you can add or skip the metainfo by just
adding or commenting out the previous statement (and restart the app).

## Mini Tutorial

### Check list

1. Install and setup the FF Extension component and the gem
2. Start/restart the app
3. Render any page in Firefox
4. Open Firebug (F12)
5. Select the "HTML" tab
6. Uncheck "Show Comments" in the HTML tab menu
7. Select the "Markers" tab in the Firebug HTML side panel
8. Check "dryml" option in the Markers tab menuUsage

### Usage

Select any node in the HTML panel or click on the Firebug's inspect icon and hover the mouse on any part of the page,
then click on it to select the node: the Markers panel will be populated with all the markers that include that
specific node. They are listed from close to far. The closest are the most specific markers that wrap the selected
node: e.g. an \<a\> tag that produces a specific link; the farest are the most general: e.g. a \<page\> tag that wraps
the whole page (including the \<a\> tag listed at the beginning).

Hovering up and down in the Markers list may be useful to understand what specific dryml statement is creating the
specific highlighted part in the page and HTML source, and eventually helps to chose what to override. (Notice that
invisible page-parts are highlighted only in the source and have a dimmed color.)

You can open any dryml file (at the right line) by clicking on the path listed in the marker's table. You can close
it by clicking on it again. If you hold the "Ctrl" or the "Alt" key while you click on a path,
you will open the file in a new FF tab instead: that might be useful when you need to explore a large file.

The green paths (with an ending "+") are editable because they are application files,
while the blue paths are just viewable, because they are libraries or auto-generated files that doesn't make sense to
edit.

If you want to save an edited file, just close it and FireMarker will ask if you want to save it.

## TO DO

Add "edit in external editor" feature to allow to open the dryml file in your preferred IDE.

## Copyright

Copyright (c) 2011 by Barquin International<br>
Designed and developed by Domizio Demichelis<br>
See LICENSE for details.
