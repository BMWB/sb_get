####  1、整洁架构思想
 
整洁架构(Clean Architecture)是由Bob大叔在2012年提出的一个架构模型，顾名思义，是为了使架构更简洁。

![image](https://github.com/BMWB/sb_get/assets/17972497/44528a62-4f46-4c09-96eb-d320ecefed71)


依赖规则：用一组同心圆来表示软件的不同领域。一般来说，越深入代表你的软件层次越高。外圆是战术是实现机制，内圆的是核心原则。

这条规则规定软件模块只能向内依赖，而里面的部分对外面的模块一无所知，也就是内部不依赖外部，而外部依赖内部。

同样，在外面圈中使用的数据格式不应被内圈中使用，特别是如果这些数据格式是由外面一圈的框架生成的。

这样做的最大好处是当系统的外部模块不得不改变时（比如，替换已有的过时的数据库系统），系统的内层模块不需要做任何改变。

干净架构的核心思想是将系统分为不同的层级和组件，每个层级和组件都有其独特的职责和关注点，它们之间通过定义清晰的接口和依赖关系来进行交互。干净架构中通常包括以下几个层级和组件：

* 实体层（Entity Layer）：负责定义系统中的业务实体和值对象，并定义它们之间的关系和行为。
* 用例层（Use Case Layer）：负责定义系统的业务逻辑和用例，实现业务流程和规则。用例层通常由用例交互器（Interactor）和用例工厂（Factory）等组件组成。
* 接口适配层（Interface Adapter Layer）：负责将系统的用例层输出适配为外部接口，并将外部接口的输入适配为用例层输入。
* 接口适配层通常由控制器（Controller）、网关（Gateway）和Presenter等组件组成。
* 框架和驱动层（Framework &amp; Driver Layer）：负责提供系统所需的基础设施和框架支持，如数据库、网络通信、邮件发送等。框架和驱动层通常由数据库框架、Web框架、UI框架、消息队列框架等组件组成。干

#### 净架构的优点包括：

* 提高系统的可维护性和可扩展性：通过分离业务逻辑和技术细节，来提高系统的可维护性和可扩展性。
* 实现业务逻辑的解耦和分离：通过将业务逻辑放在系统的核心位置，并通过不同的层级和组件来实现业务逻辑的分离和解耦。
* 提高系统的可测试性：通过定义清晰的接口和依赖关系，来提高系统的可测试性和测试覆盖率。

**依赖倒置（Dependency Inversion）是干净架构中的一个重要概念，其核心思想是高层模块不应该依赖于低层模块，而是应该依赖于抽象接口或协议。这就是所谓的“依赖倒置原则”（DIP，Dependency Inversion Principle）。**

在干净架构中，依赖倒置的体现主要有以下几个方面：

* 高层模块依赖于抽象接口或协议，而不是具体实现。这意味着高层模块不需要知道低层模块的具体实现细节，只需要关心接口或协议定义的功能和行为即可。
* 抽象接口或协议由低层模块实现和提供，而高层模块依赖于这些抽象接口或协议。这使得高层模块可以更加灵活地使用不同的低层模块，而不需要修改高层模块的代码。
* 抽象接口或协议可以通过接口适配层来实现，从而将不同的实现细节隐藏在低层模块中。这使得高层模块可以更加灵活地使用不同的实现方式，而不需要了解实现细节。

## 开始

这个项目是为了展示我们如何在Flutter应用程序中使用清洁架构。应用程序的架构如下-

![Clean Architecture design](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1)

项目的现有文件夹结构如下-

<img width="248" alt="image" src="https://user-images.githubusercontent.com/7704510/158588239-ff4ceb3e-f163-44ff-9b53-f0a8d631a19e.png">

 Modular提出要解决四个问题：

* 模块化路线。
* 模块化依赖注入。
* DDD设计
* flutter与native 混合开发的多入口('vm:entry-point') 设计


在整体架构中，我们将整个应用程序作为单个模块，我们以快速而优雅的方式设计我们的软件，利用 Flutter💙 的所有令人惊叹的功能。然而，以“整体”方式生成更大的应用程序可能会在维护和可扩展性方面产生技术债务。考虑到这一点，开发人员采用了架构策略来更好地划分代码，最大限度地减少对项目可维护性和可扩展性的负面影响。

通过更好地划分特征范围，我们获得：

* 提高对功能的理解。
* 更少的破坏性变化。
* 添加新的不冲突的功能。
* 项目主营业务规则盲点少。
* 提高了开发商的营业额。
* 通过更具可读性的代码，我们可以延长项目的生命周期。



好的，下面是关于模块化路线、模块化依赖注入、DDD设计以及Flutter与Native多入口设计的具体内容。

## 模块化路线

模块化路线是指将应用拆分成多个模块来进行开发。每个模块都是独立的，可以独立开发、测试、部署和维护。这种开发方式可以提高应用的可维护性、可扩展性和可重用性。

在 Flutter 中，我们可以使用多种模块化方案来实现模块化路线，如 Flutter Modular、GetX、BLoC 等。这些库都提供了一套完整的模块化开发框架，可以帮助我们更加方便地组织、管理和开发模块化应用。

Flutter Modular 是一款基于模块化的 Flutter 应用开发框架，它提供了完整的路由、依赖注入和状态管理等功能。通过使用 Flutter Modular，我们可以更加方便地组织和管理应用的模块，同时也可以提高代码的可重用性和可测试性。

GetX 是一款轻量级的 Flutter 应用开发框架，它提供了路由、依赖注入、状态管理和网络请求等功能。与 Flutter Modular 不同，GetX 更加注重简洁和灵活性，可以让开发者更加自由地组织和管理应用的模块。

BLoC 是一种基于单向数据流的状态管理方案，它将应用的状态和 UI 完全分离，可以使得应用更加易于维护和扩展。通过使用 BLoC，我们可以将应用拆分为多个模块，每个模块负责特定的业务逻辑和 UI 展示，从而使得应用更加清晰和易于维护。

## 模块化依赖注入

模块化依赖注入是指在模块化开发中使用依赖注入来管理模块之间的依赖关系。通过使用模块化依赖注入，我们可以更加方便地组织和管理应用的依赖关系，同时也可以提高代码的可重用性和可测试性。

在 Flutter 中，我们可以使用多种依赖注入库来实现模块化依赖注入，如 GetIt、Provider、Injectable 等。这些库都提供了一套完整的依赖注入框架，可以帮助我们更加方便地管理应用的依赖关系。

GetIt 是一款简单易用的依赖注入库，它可以帮助我们在应用中注册和获取依赖项。通过使用 GetIt，我们可以将应用的依赖关系解耦，提高代码的可重用性和可测试性。

Provider 是一款基于 InheritedWidget 的依赖注入库，它可以帮助我们在应用中共享状态和数据。通过使用 Provider，我们可以更加方便地管理应用的状态和数据，从而提高代码的可维护性和可扩展性。

Injectable 是一款基于代码生成的依赖注入库，它可以帮助我们自动生成依赖注入代码。通过使用 Injectable，我们可以更加方便地管理应用的依赖关系，同时也可以提高代码的可重用性和可测试性。

## DDD设计

DDD 设计是一种将业务领域作为设计核心的软件设计方法。在 DDD 设计中，我们将应用拆分为多个领域模型，每个领域模型负责实现特定的业务领域。通过使用 DDD 设计，我们可以更加清晰地理解业务需求，提高代码的可维护性、可扩展性和可测试性。

在 Flutter 中，我们可以使用 BLoC、Clean Architecture 等设计模式来实现 DDD 设计。

BLoC 是一种基于单向数据流的状态管理方案，它将应用的状态和 UI 完全分离，可以使得应用更加易于维护和扩展。通过使用 BLoC，我们可以将应用拆分为多个领域模型，每个领域模型负责实现特定的业务逻辑和 UI 展示，从而使得应用更加清晰和易于维护。

Clean Architecture 是一种将应用拆分为多个层次的设计方法，每个层次负责不同的职责。在 Clean Architecture 中，我们将应用分为四个层次：实体层、用例层、接口适配层和框架层。通过使用 Clean Architecture，我们可以更加清晰地分离业务逻辑和技术实现，从而提高代码的可维护性和可扩展性。

## Flutter与Native多入口('vm:entry-point')设计

Flutter 支持在一个应用中同时使用多个 Flutter 模块和 Native 模块，可以通过使用多入口('vm:entry-point')来实现。

在 Flutter 中，我们可以通过在 pubspec.yaml 文件中添加多个入口来创建多个 Flutter 模块。例如：

```
flutter:
  module:
    androidPackage: com.example.module1
    iosBundleIdentifier: com.example.module1
  entry_points:
    module1:
      main: lib/module1_main.dart
    module2:
      main: lib/module2_main.dart
```

在上述代码中，我们定义了两个入口：module1 和 module2，分别对应 lib/module1_main.dart 和 lib/module2_main.dart 文件。

在 Native 模块中，我们可以通过使用 FlutterEngine 来加载和运行 Flutter 模块。例如：

```
FlutterEngine flutterEngine = new FlutterEngine(context);
flutterEngine.getDartExecutor().executeDartEntrypoint(
  DartExecutor.DartEntrypoint.createDefault()
);
```

在上述代码中，我们创建了一个 FlutterEngine 对象，并通过 executeDartEntrypoint 方法来运行默认的入口点。如果我们要运行指定的入口点，可以使用 executeDartEntrypoint 方法的重载版本。例如：

```
flutterEngine.getDartExecutor().executeDartEntrypoint(
  DartExecutor.DartEntrypoint.create("module1"),
  new DartExecutor.DartEntrypointListener() {
    @Override
    public void onDartEntrypointCreated(DartExecutor.DartEntrypoint dartEntrypoint) {
      // 入口点创建成功后的回调
    }
  }
);
```

在上述代码中，我们通过 executeDartEntrypoint 方法的重载版本指定了要运行的入口点，并在创建入口点后执行了一个回调函数。

