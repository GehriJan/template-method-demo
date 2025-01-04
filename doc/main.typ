#import "@preview/charged-ieee:0.1.3": ieee
#import "@preview/acrostiche:0.4.0": *

#init-acronyms((
  "TMDP": ("Template Method Design Pattern"),
  "TM": ("Template Method"),
))
#set page(numbering: "1")
#show raw: it => text(
      font: "PT Mono",
      it
)
#show: ieee.with(
  title: [Software Design Pattern: Template Method],
  abstract: [
    #lorem(100)
  ],
  authors: (
    (
      name: "Anton Seitz",
      department: [INF22B],
      organization: [DHBW],
      location: [Stuttgart, Germany],
      email: "email-adress-to-add"
    ),
    (
      name: "Jannis Gehring",
      department: [INF22B],
      organization: [DHBW],
      location: [Stuttgart, Germany],
      email: "inf22115@lehre.dhbw-stuttgart.de"
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#outline(depth: 2)

= Motivation

= The Template Method Design Pattern

With the #acrf("TMDP"), the algorithm is divided into several abstract steps,
which are called in the _#acr("TM")_.
This method implements the solution to the problem on a high level,
allowing the different, specific step implementations to deal with the differing contexts.
The steps are aggregated in an abstract class.

When the _#acr("TM")_ is to be applied to a new context, a sub-class of the abstract class is created.
Then, at minimum all required functions declared in the abstract class have to be implemented, before the #acr("TM") can be performed for the new class.


== Different types of abstract steps

In general, there are three types of abstract steps:

1. *Required abstract steps*\
  These steps are defined as abstract methods in the abstract class. Therefore, they have to be implemented by every concrete class, otherwise the template method cannot be performed.
2. *Optional abstract steps*\
  For these steps, a default implementation exists in the abstract class. Therefore, they do not have to be implemented by the concrete class but can be if the context requires so.
  This can be useful when steps are _exactly_ the same for multiple contexts.
3. *Hook methods*\
  For these steps, no implementation is given in the abstract class, but they are not abstract classes either. Instead, they can be implemented in concrete classes for them to _hook into_ the template method. One example would be the allowance of logging in between of different steps of the template method.

== Class diagram
The following class diagram displays the different classes and the different types of abstract steps.
Whilst the functions `required_step1` and `required_step2` are implemented by every concrete classes, `optional_step` and `hook_method` are only implemented by some of the concrete classes.

#figure(
  image("assets/template-pattern-class-diagram.drawio.png"),
  caption: [Class diagram showcasing the different concepts of #acr("TMDP")],
) <class-diagram>

// == Sequence Diagram
// The following sequence diagram
// #figure(
//   image("assets/template-pattern-sequence-diagram.drawio.png"),
//   caption: [Sequence diagram showcasing the different concepts of #acr("TMDP")],
// ) <class-diagram>

= Example

== General project information
//project structure
//setup

//context
For showcasing #acr("TMDP"), a context had to be chosen which fits the situation of similar algorithms with differing concrete implementations. The implemented application, in short, fetches, processes and displays data of differing source and contexts. The different contexts are presented subsequently:

1. *`CryptoVisualize` - Price of Bitcoin*\
  The price of the wide-spread crypto currency Bitcoin is retrieved for every day since the first of July 2024. The data is then being transformed and visualized as a plotly-line-chart.
2. *`DogVisualize` - Picture of Dog*\
  A random picture of a dog is being fetched and displayed.
3. *`AutobahnVisualize` - German Highway lorries*\
  Informations regarding different lorries of the notorious german highways ('Autobahn') are fetched. Then, the lorries are displayed on a plotly-map chart. They are color-coded according to the highway they belong to, which allows the retracing of individual highways

== Usage

//how to use
The kind of visualization displayed can be configured by a command line argument when running this command:
#figure(
  ```sh python3 src/main.py -c [specifier] ```
)
These are the specifiers for the different classes:
#figure(
  table(
    columns: (auto, auto),
    align: center,
    table.header(
      [*context*],[*specifier*],
    ),
    [`CryptoVisualize`], [`crypto`],
    [`DogVisualize`], [`dog`],
    [`AutobahnVisualize`], [`autobahn`],
  )
)

//examples of usage
Example outputs with their corresponding commands are presented subsequently.
#figure(
  image("assets/example_crypto.png"),
  caption: [Command: ```sh python3 src/main.py -c crypto```]
)
#figure(
  image("assets/example_dog.png"),
  caption: [Command: ```sh python3 src/main.py -c dog```]
)
#figure(
  image("assets/example_autobahn.png"),
  caption: [Command: ```sh python3 src/main.py -c autobahn```]
)

== Class diagram
//class diagram

== Concepts of #acr("TMDP") in the example

= Real-World examples

= Pro/Con of Template Method

// Bezugnahme auf Beispiel aus der Praxis

= Differentiation to other patterns

= Outlook
