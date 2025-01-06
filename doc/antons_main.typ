= Motivation

In software development, a recurring challenge is managing processes that share a common structure but require variability in implementation. For example, consider scenarios such as:

- Rendering different types of documents (e.g., PDF vs. HTML) with a consistent generation pipeline.
- Performing data analysis with standardized preprocessing steps but customizable algorithms for statistical computations.

Without proper design, such problems often lead to code duplication, hard-to-maintain conditional logic, and inconsistency. As the need for variations grows, monolithic designs become fragile and error-prone.

An equally significant challenge is maintaining flexibility within a controlled structure. Many processes demand a fixed sequence of operations, such as initializing resources, executing a task, and cleaning up. The question is: how can we enforce this overarching structure while enabling flexibility in specific steps?


...

= Real-World Examples

1. **Document Generation Frameworks**
   Consider a reporting tool that generates financial summaries in different formats, such as PDF or Excel. The Template Method ensures a standardized process (e.g., fetching data, formatting content, exporting) while allowing customization in the format-specific export steps.

2. **Game Engines (e.g., Unreal Engine)**
   Unreal Engine provides hooks like `BeginPlay()` and `Tick()` within its `Actor` class. Developers implement these hooks to customize behavior while adhering to the engine's predefined game loop. This ensures consistency across game objects while allowing for diverse gameplay logic.

3. **Web Frameworks**
   Web frameworks like Django utilize Template Method principles in their lifecycle hooks. For example, the `save()` method of a model enforces a sequence (validate data, execute database operations) while allowing developers to override certain steps (e.g., customizing validation).

4. **Home Construction**
   Builders follow a predefined sequence (laying the foundation, erecting the frame, installing plumbing and wiring) but allow customization in later stages, such as choosing paint colors or flooring materials. This analogy from @sourcemaking-template-method reflects how Template Method separates standardized steps from customizable ones.

= Advantages and Disadvantages

**Advantages**
- **Reusability**: The pattern abstracts shared behavior into a base class, promoting code reuse across multiple implementations [@McDonough2017, pp. 249-250].
- **Consistency**: Enforces a fixed sequence of operations, improving readability and maintainability.
- **Extensibility**: Subclasses can introduce new behaviors by overriding hooks, adhering to the open-closed principle [@McDonough2017, p. 249].
- **Reduced Duplication**: Centralizes common logic, eliminating repetitive code [@sourcemaking-template-method].

**Disadvantages**
- **Inheritance Dependency**: Relies on inheritance, potentially leading to tight coupling and reduced flexibility [@McDonough2017, p. 252].
- **Limited Granularity**: Variability is limited to predefined hooks, which may not accommodate all use cases.
- **Global Impact of Changes**: Modifying the base class can unintentionally affect all subclasses, increasing the risk of errors [@McDonough2017, p. 253].

= Differentiation from Other Patterns

The Template Method is often compared to other patterns due to its structural similarities. However, key distinctions highlight its unique role.

#table(
  columns: (auto, auto, auto),
  [
    [*Pattern*], [*Purpose*], [*Key Difference from Template Method*],
    [Strategy Pattern],
    [Encapsulates algorithms as interchangeable objects, allowing runtime flexibility.],
    [Strategy replaces an entire algorithm dynamically, while Template Method enforces a fixed structure and allows variations only in specific steps. For example, a payment processor could use Strategy to switch between credit card and PayPal payments at runtime, but Template Method would ensure that the sequence of authorization, processing, and logging remains fixed [@gamma1993design, p. 412].],
      [Factory Method],
      [Defines a method for creating objects, enabling subclasses to determine the specific type of object created.],
      [Factory Method focuses on object creation, while Template Method defines the structure of an algorithm. For instance, a factory might decide whether to create a `Car` or `Truck`, but a Template Method defines how the vehicle's components (e.g., engine, wheels) are assembled [@McDonough2017, pp. 249-250].],
      [State Pattern],
      [Encapsulates state-based behavior within an object, allowing it to alter its behavior when its internal state changes.],
      [State Pattern dynamically modifies behavior based on state, whereas Template Method enforces a static sequence of steps with optional variations. For example, a vending machine might use State to manage coin insertion, selection, and dispensing, but Template Method would dictate the standardized order of operations for a transaction [@gamma1993design, p. 412].],
      [Decorator Pattern],
      [Dynamically adds responsibilities to objects without modifying their structure.],
      [Decorator focuses on enhancing object behavior at runtime, while Template Method structures an algorithm. For instance, a text editor might use Decorator to add features like spell check or formatting dynamically, whereas Template Method ensures the editing pipeline (load file, edit, save) remains consistent [@gamma1993design, p. 412].],
  ]
)

= Outlook

The Template Method pattern remains integral to software frameworks, where it ensures consistency while allowing client-specific customizations. Its reliance on inheritance, however, makes it less aligned with modern programming paradigms emphasizing composition and functional programming [@McDonough2017, pp. 253-254].

In frameworks, Template Method embodies the "Hollywood Principle"—"don't call us, we'll call you"—by retaining control over the algorithm structure while delegating customizable steps to clients [@sourcemaking-template-method]. Despite its limitations, the pattern's ability to manage variability within a standardized process ensures its ongoing relevance in domains like UI frameworks, testing suites, and game engines.
