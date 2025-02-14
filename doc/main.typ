#import "@preview/charged-ieee:0.1.3": ieee
#import "@preview/acrostiche:0.4.0": *

#init-acronyms((
  "TMDP": ("Template Method Design Pattern"),
))
#set page(numbering: "1")
#show raw: it => text(
      font: "PT Mono",
      it
)
#show: ieee.with(
  title: [Software Design Pattern: Template Method],
  abstract: [
    Oftentimes in modern software projects, the same procedure has to be performed in differing contexts.
    Considering every context by using control structures makes the code less readable, maintainable and scalable.
    #acr("TMDP") solves this problem by introducing an abstract class which contains the template method, a high-level algorithm solving the problem on a general level. The different parts of the algorithm are implemented for the different contexts, ensuring flexibility _and_ scalability.
    To showcase #acr("TMDP"), we implemented a Python program with an abstract class and 3 concrete classes. All of them implement a fetch-process-visualize procedure.
    At last, we elaborate on advantages and disadvantages of #acr("TMDP") and refer to related software design patterns.
  ],
  authors: (
    (
      name: "Jannis Gehring",
      department: [INF22B],
      organization: [DHBW],
      location: [Stuttgart, Germany],
      email: "inf22115@lehre.dhbw-stuttgart.de"
    ),
    (
      name: "Anton Seitz",
      department: [INF22B],
      organization: [DHBW],
      location: [Stuttgart, Germany],
      email: "inf22052@lehre.dhbw-stuttgart.de"
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#outline(depth: 1)

= Motivation
In software development, many problems arise from the need to manage processes that share a common structure but vary in detail. For example, consider scenarios where multiple algorithms or workflows follow the same sequence of steps but require customization for specific use cases. Ensuring consistency in such processes often leads to code duplication, which complicates maintenance and increases the likelihood of errors.

When developers attempt to address these issues using conditional logic (e.g., `if` or `switch` statements), the result is often code that is harder to understand, modify, and extend. As the number of variations grows, these conditionals become unwieldy, making the codebase fragile and less reusable.

Another challenge lies in maintaining _flexibility_ without sacrificing _control_. Certain processes demand a fixed order of operations - for instance, initializing resources, executing a task, and cleaning up afterward - but may require variation in how individual steps are implemented. Developers must balance enforcing a standardized sequence with providing enough adaptability to accommodate different requirements.

How can we structure code to manage such recurring problems effectively? The solution lies in a design approach that enforces the overall sequence of operations while allowing variation in specific steps - a balance that promotes reusability, consistency, and scalability.

= The #acrf("TMDP")

With the #acrf("TMDP"), the algorithm is divided into several abstract steps,
which are called in sequence in the _template method_.
This method implements the solution to the problem on a high level,
allowing the different, specific step implementations to deal with the differing contexts.
The steps as well as the template method are aggregated in an abstract class.

When the template method is to be applied to a new context, a sub-class of the abstract class is created.
Then, at minimum all required functions declared in the abstract class have to be implemented, before the template method can be performed for the new class.


== Different types of abstract steps


One differentiates between different types of methods in the template method. The number of different types of methods and the naming varies (@wikipedia and @McDonough2017 count 2, @refactoring_guru and @cooper2000java 3), but the underlying concepts of _abstraction_ and _default implementation_ stay the same. We count three types of abstract steps in the template method @refactoring_guru:

1. *Required abstract steps*\
  These steps are defined as abstract methods in the abstract class. Therefore, they have to be implemented by every concrete class, otherwise the template method cannot be performed.
2. *Optional abstract steps*\
  For these steps, a default implementation exists in the abstract class. Therefore, they do not have to be implemented by the concrete class but can be if the context requires so.
  This can be useful when steps are _exactly_ the same for multiple contexts.
3. *Hook methods*\
  For these steps, no implementation is given in the abstract class, but they are not abstract classes either. Instead, they can be implemented in concrete classes for them to _hook into_ the template method. One example would be the allowance of logging in between of different steps of the Template Method.

== Class diagram

The following class diagram displays the different classes and the different types of abstract steps.
Whilst the functions `required_step1` and `required_step2` are implemented by every concrete classes, `optional_step` and `hook_method` are only implemented by some of them.

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

//context
For showcasing #acr("TMDP"), a context had to be chosen which fits the situation of similar algorithms with differing concrete implementations. The implemented application, in short, fetches, processes and displays data of differing source and contexts. The different contexts are presented subsequently:

1. *`CryptoVisualize` - Price of Bitcoin*\
  The price of the wide-spread crypto currency Bitcoin is retrieved for every day since the first of July 2024. The data is then being transformed and visualized as a plotly line-chart.
2. *`DogVisualize` - Picture of dog*\
  A random picture of a dog is being fetched and displayed.
3. *`AutobahnVisualize` - German highway truck parks*\
  Informations regarding different truck parks of the notorious german highways ('Autobahn') are fetched.
  Then, the truck parks are displayed on a plotly map-chart. They are color-coded according to the highway they belong to, which allows the retracing of individual highways.

== Project Setup
For implementing #acr("TMDP") we used the programming language Python (version 3.13.0). Python is easy to read and allows to focus on the main concepts of this demonstration. The module `abc` (Abstract Base Classes) provides the necessary classes/decorators for implementing #acr("TMDP").
The project is structured in three folders:
- `src` contains the source code for the #acr("TMDP"). `model.py` implements the class structure, including the concrete classes. `args.py` deals with the command-line arguments and `main.py` brings both together to a working program
- `tests` contains the tests
- `doc` contains the files for this documentation.

The project can be setup by the following steps:
1. `sh python3 -m venv .venv`
2. `sh source .venv/bin/activate`
3. `sh pip install -r requirements.txt`

== Usage

To execute the program, run `src/main.py`.
The kind of visualization displayed can be configured by a command line argument:
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
=== Tests

Tests of the program have been written using the python package `pytest`.
They can be found in `tests/test.py` and run by
#figure(
  ```sh pytest tests/test.py -v```
)
.

== The #acr("TMDP") in the example
=== template method

The template method implements the basic fetch-process-visualize algorithm:
#figure(
  ```python
    # template method
    def show_me_stuff(self) -> None:
        api_url = self.get_api_url()
        content = self.api_requests(api_url)
        data = self.process_content(content)
        self.print_report(data)
        self.visualize_data(data)
        return
  ```,
  caption: [The example template method.]
)

=== Required abstract steps

`get_api_url` and `visualize_data` are different for every class and therefore implemented as abstract methods.
In general, default implementations of functions should be given if possible to increase ease of use and standardization. Both functions, however, have no default implementation because they differ _for every concrete class_.
In python, this can be implemented by a decorator imported from `abc` and an empty body:
#figure(
  ```python
    @abstractmethod
    def get_api_url(self) -> str:
        pass
  ```,
  caption: [Example of required abstract step in implementation.]
)
=== Optional abstract steps

`api_requests` and `process_content` have default implementations.
For `api_requests`, it is just performing one api request and returning the content; for `process_content`, it is returning the input. These functions are implemented without additional decorators and with a proper function body:
#figure(
  ```python
    def process_content(self, content):
        return content
  ```,
  caption: [Example of optional abstract step in implementation.]
)
=== Hook methods
`print_report` is a hook method allowing the developer to print informations before visualizing the data.
`CryptoVisualize` is the only class utilizing this method.
It is implemented as a normal function with an empty body:
#figure(
  ```python
    def print_report(self, data):
        pass
  ```,
  caption: [Example of hook method in implementation.]
)

== Further concepts of #acr("TMDP") in the example
The implementation of `api_requests` in `AutobahnVisualize` is to be highlighted, because it is the only class overwriting the default implementation. This is due to the fact, that the first API request only returns the names of the highways and not the truck parks themselves. The default implementation is rather general, which is why `AutobahnVisualize.api_requests()` can refer to it when making requests. This approach adapts to the API endpoints whilst still ensuring a standardized handling of API(-error)s:

#figure(
  ```python
    def api_requests(self, api_url):
        """Request highway names, then request truck parks for individual highways."""
        content_highways = (
            super()
            .api_requests(api_url)
            ["entries"][:10]
        )
        all_truck_parks = []
        for highway in content_highways:
            url = f"https://api.deutschland-api.dev/autobahn/{highway}/parking_lorry"
            truck_parks = (
                super()
                .api_requests(url)
                ["entries"]
            )
            all_truck_parks.append(truck_parks)
        return all_truck_parks

  ```,
  caption: [The overwritten version of `api_requests` in `AutobahnVisualize`.]
)

= Real-World examples

1. *Testing Frameworks (JUnit)*\
   JUnit uses template method principles to enforce a structured flow in test execution. Methods such as `setUp()` and `tearDown()` serve as hooks, while `executeTest()` is a required step for specific test logic.

2. *Game Development (Unreal Engine)*\
   In Unreal Engine, the `Actor` class exemplifies the template method pattern. Methods such as `BeginPlay()` and `Tick()` allow developers to inject custom logic while adhering to the engine's game loop.

3. *Oatmeal Preparation (Non-programming)*\
   @McDonough2017 provides an analogy of oatmeal preparation, illustrating how a fixed sequence of steps (gather ingredients, prepare, cook, and serve) can have flexibility in implementation depending on factors like the type of oatmeal and the cooking method (e.g., stovetop or microwave). This mirrors the template method's ability to define an overarching structure while allowing subclasses to handle details [@McDonough2017, pp. 247-251].

= Pro/Con of template method

The template method pattern offers both benefits and drawbacks:

== *Advantages*
- *Reusability*\
  Encourages code reuse by defining a reusable algorithmic structure applicable across various contexts [@McDonough2017, pp. 249-250].
- *Scalability*\
  New behaviors can be introduced by subclassing without altering the existing template, adhering to the open-closed principle [@McDonough2017, p. 249].
- *Consistency*\
  Enforces a standardized process flow, enhancing readability and maintainability [@McDonough2017, pp. 250-251].
- *Reduced Duplication*: Centralizes common logic, eliminating repetitive code [@sourcemaking-template-method].

== *Disadvantages*
- *Inheritance Dependency*\
  Relying on inheritance can limit flexibility and lead to tightly coupled designs, which @McDonough2017 notes is a potential drawback of class-based patterns [@McDonough2017, p. 252].
- *Complexity for Simple Use Cases*\
  For straightforward problems, introducing an abstract template may introduce unnecessary complexity [@McDonough2017, pp. 252-253].
- *Global Impact of Changes*\
  Modifications in the base class can inadvertently propagate to all subclasses, introducing potential bugs [@McDonough2017, p. 253].


= Differentiation from Other Patterns

The Template Method is often compared to other patterns due to its structural similarities. However, key distinctions highlight its unique role.

- *Strategy Pattern*
  - *Purpose*: Encapsulates algorithms as interchangeable objects for runtime flexibility.
  - *Difference*: Strategy replaces an entire algorithm dynamically, while Template Method fixes the overall structure and allows variation only in specific steps.
  - *Example*: A payment processor might use Strategy to switch between credit card and PayPal payments, while Template Method standardizes the sequence of authorization, processing, and logging [@gamma1993design, p. 412].

- *Factory Method*
  - *Purpose*: Defines a method for creating objects, letting subclasses specify the object type.
  - *Difference*: Factory Method focuses on object creation, whereas Template Method defines an algorithm's structure.
  - *Example*: A factory may decide between creating a `Car` or `Truck`, while Template Method standardizes the assembly sequence (e.g., engine installation, wheel attachment) [@McDonough2017, pp. 249-250].

- *State Pattern*
  - *Purpose*: Encapsulates state-based behavior, allowing objects to change behavior dynamically as their state changes.
  - *Difference*: State modifies behavior based on an object's internal state, whereas Template Method enforces a fixed sequence of steps with variation points.
  - *Example*: A vending machine uses State to handle coin insertion, selection, and dispensing, while Template Method enforces a consistent transaction workflow [@gamma1993design, p. 412].

- *Decorator Pattern*
  - *Purpose*: Dynamically adds responsibilities to objects without altering their structure.
  - *Difference*: Decorator enhances object behavior at runtime, while Template Method defines a standardized algorithm structure.
  - *Example*: A text editor might use Decorator to add spell-checking or formatting features dynamically, while Template Method enforces a consistent pipeline (e.g., load file, edit, save) [@gamma1993design, p. 412].


= Outlook

While the template method remains a robust tool for algorithm design, its reliance on inheritance may be less favored in modern design paradigms emphasizing composition and functional programming [@McDonough2017, pp. 253-254]. Nonetheless, its ability to enforce structure in repetitive workflows ensures its continued relevance in certain contexts.