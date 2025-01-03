#import "@preview/charged-ieee:0.1.3": ieee
#import "@preview/acrostiche:0.4.0": *

#init-acronyms((
  "TMDP": ("Template Method Design Pattern"),
))

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

= Introduction
== Motivation

= The Template Method Design Pattern

// Textuelle Beschreibung
// Klassen-Diagramm
// Sequenz-Diagramm

== Example

// Beispielhafte Erklärung des Patterns am Code
// Weitere Beispiele aus der Praxis

== Pro/Con of Template Method

// Bezugnahme auf Beispiel aus der Praxis

== Differentiation to other patterns

= Outlook
