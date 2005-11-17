Doesn't handle "/" in symbol names

system should have list of files
  printing file names
  print files in a 2 or 3 column layout
  links to CVS / Darcs / Etc
    make part of method somewhere
  using htmlize form source + extend with links to rest of (relevant) documentation

package dependency graphs

system dependency graphs

Overview documentation
Slots
Setfs
List of bugs, etc...
CVS access

(setf sp (document-system 'eksl-system 'tinaa "home:tinaa-system;"))
  The root part contains two instance of itself - it has itself as a parent


*default-packages-to-ignore* needs to be updated as other systems are loaded

This fails because eksl-systems don't know how to handle symbol-kinds

(timeit (:report t)
        (document-system 'eksl-system 'hac "home:hac;"
                         :symbol-kinds '(:external)))

#|
index doesn't know about packages
index only lists packages
print symbols with package prefix?
show list of files for system
show list of files for package -- how does this work!?
  need to add to the list of subpart kinds but only when documenting a package
  as part of a system
packages are not "descended" into
add documentation string to eksl-system defs
should skip ccl, ae-tools, others...
systems listed as if they contain themselves
In output-table-summary, need to look at (subparts (name-holder part))
  but also want to ignore things that are not "part of" the current part.
  perhaps look at 'parents'
|#


;;; ---------------------------------------------------------------------------

handle doc-strings better (<, >, line breaks)

(setf <symbol>) in url-for-part

Current simple mode is that we create pages for everyone that has a 
  :detail display-part method.

linking is still a bit of mystery
From Zach Beane: Random blue sky: why limit symbol documentation lookup to the HyperSpec? It'd be nice if package authors provided a way to map from symbols to documentation URLs, preferably in a programmatic way that integrates with SLIME.

Should we allow different views of a thing

sort container for associative containers

how do we extend it 
  e.g., get internal or external symbols of a package

  options become part of a web form? generate pages for all option combinations?

given a system and a part-name, I get parts. I'll need to (potentially) make
  "systems" out of these parts. So I'll need to say how to do that.

This will be consy as hell, but I don't think that's an issue

Note that I'm making collectors here rather than mappers... is that bad

Part -> HTML
  class -> HTML
  maybe two forms 
    single page (all in one)
    frame style (lists of subparts on side for jumping too)

Global options / part options (means defined by system)
  use reflection to determine options for system being documented
    and ask up front

documentation is made up of lots of parts
  I could ask for different pages at different times
there is summary documentation and detail documentation
I can insert summary documentation in the 'parent's' page
some things have no detail -- then they don't have their own page

We can imagine different styles
  e.g., the alphabetical style used in Tapir

Lint would be another kind of documentation

Should say "no documentation available" if methods aren't written.
  maybe (use CSS somehow to insert text or not)

~ make-part needs to return singletons

;;; ---------------------------------------------------------------------------

Is there a nice way to handle things that are the same but naturally divide:
  direct-slot, inherited-slots. Are these two kinds of slots? Are they one 
  kind with a marker that says which sub-kind they are. If we want to easily
  display separate lists, the former makes more sense. Can this handled more
  easily in the output side?

Suppose my superclass is in a different package. That's ok if I'm doing a 
system, but what if I'm doing a package. No link. Specialized link. Broken link?
How does find-part know how to handle this.

Currently, packages have gf, methods, classes, etc. But not slots. Classes
have slots. (The same package thing comes up here of course with inherited slots).
When I (find-part * 'slot <name>), what should happen. Should I look for it
in the package -- only one name holder. Or in the class? 

Should make the part specs returned by subpart-kinds return instances of
something with structure. This could be a way of supporting things like
all-slots, direct-slots, inherited-slots.

Slots are still just symbols. But (in doclisp sense) of a special kind.

Packages could have symbols though I might not want them reported.
(Rather they'd go in a separate page / index page).

One way to do this is to have everything in the package. If you're doing a
system, then the system looks in each package [heck, it would know in which 
packge to look]. This would mean that either the package's subpart-kinds
must include all the kinds of its subparts or that the package doesn't mind
creating subpart-kinds that it knows nothing about.

Parts can have many parents. E.g., a slot. Should we be explicit about this.
What is the parent for?

;;; ---------------------------------------------------------------------------

package summary needs to show readers / writers
index should deal with slots readers/writers?
setf's
function list need to include setf's as well
if slots are exported, don't show them if we're only doing external
if symbols aren't exported, should not show them in lists

Extend:
(defun document-symbol-p (symbol)
  (find (symbol-package symbol) (packages-to-document)))
(defun packages-to-document ()
  ;; hack
  (list (find-package (name *root-part*))))

to do eksl-system, need to clarify name-holders and indexes
want indexes to do every symbol (sub-indexes?)

counts of different kinds of things in package summary

color index 'sections'
make go to top nicer
index seems spread out -- table in table problem?
on class page
  also default-initargs (ccl::CLASS-DEFAULT-INITARGS)
:summary isn't used right now...
links to summaries on summary pages
links to top on summary pages
if no methods, no detail page
why are things getting internal links (#) that they shouldn't be getting
logo!?
symbols need to override documentation-exists-p
~ have summary show first bit of comment, detail show all
show direct / indirect slots on class page
show direct / indirect methods on class page ??
show direct / indirect superclasses on class page ??
show subclasses - how far down?

nice way of dealing with direct / indirect slots (for example)

do Tapir
add file detail page shows what is in it
  and includes a link to the file
do files
  include files on all detail pages
do debugging
callers
graphical subclasses
  dealing with multiple inheritance?!
  graphviz

ok - title of package 
ok - macro details
ok - function details
ok - variable details
ok - page should use real name, not nickname
ok - symbol index should show "function" even if they aren't linked
ok - class method summary no longer linking to gf pages
ok - constants
ok - not all variables seem to show up in the variables index
ok - rework index to include all necessary symbols (and always include A-Z)
ok - map-parts-from-leaves should only hit each part once.
ok -  minimum widths for name td in table-summary
ok - top file should be index
ok - index pages should have links to other indexes
ok - lower case indexes
ok - generic functions detail page
ok - getting polutents!? docing u gives us still in Krill and Hats
ok - short documentation broken
ok - methods args should link to classes
ok - rely on 5.1 and long files... sure!
ok - index for symbols should include the different links to the uses of the symbol
ok - documentation all messed
ok - links to classes from gf details page
ok - sort methods alphabeticaly
ok - every page should have a link to the root
ok - new name
ok - fix header
ok more package information: symbol counts
ok - index pages need link to Contents
ok - don't index if no function / value
ok - HTML titles of index pages
ok - documenting-page needs a title arg.
ok - make-part needs args to use for initialization
ok - alternate row colors AH
ok - on class page, slot summary should be more interesting
  allocation, readers / writers / accessors, initform, initargs
  if long, should go into detail section
ok - on gf page, need to get method / methods correct
ok - way to specify up front which symbols we want (internal / external)
ok - don't include readers / writers in gf summary
ok - each kind will need its own url/page
  i.e., the gf foo needs to be different than the class foo
ok - index includes undocumented symbols

defer - alphabet if more than k-entries for a section
