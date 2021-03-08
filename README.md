# describe-repo-schema

Declarative repository architecture

## Background and Objective

Every source code repository exists to provide some kind of asset or resource
to the outside world.
The simplest example could be a repo that stores a blog post in a single text file.
Closer to the opposite end of complexity, a repo could store source code
for a web service which relies on external dependencies,
must be compiled in a build, and includes automations for testing,
code statistics, and deployment to production infrastructure.

In both of these examples, the repo can be thought of conceptually
as a pure function with defined inputs and outputs.
In the simple example, the function takes no input,
and returns the text file as output.
In the complex example, the function receives as input
a large number of environment variables, build tools, system libraries,
and package manager repositories available on the network.
It outputs things like a compiled executable (or perhaps a container image),
configuration files for developer tools which run unit and integration tests
and generate coverage statistics,
and YAML files for the project's CI/CD providers of choice.

In addition, these outputs may have expectations about the environment
in which they will be used.
An executable is typically built for a specific architecture,
and might require environment variables at runtime (not just at build time).
Configuration for a unit testing framework
might require a specific version of that tool.
Expanding on the "repo as pure function" metaphor,
these expectations constitute information about the
"type signature" of the function's inputs and outputs.

Given a typical repo found on a site like GitHub,
this information is rarely explicitly defined, and if it is,
it is defined in prose in README or CONTRIBUTIONS documents.
One might meditate on whether the most effective way
to communicate a type signature is with written prose,
or with an actual type signature in the grammar of a programming language.
Either way, this doesn't pose a significant problem when the repo follows conventions
typical to a particular platform, say, a simple NPM package (in which case,
the `package.json` tells you practically everything you need to know),
but as project complexity grows, so too grows the variety and quantity
of developer tools in use, and you quickly reach a point of increasing drag --
even sooner for new developers and polyglot engineers who are not specialized
on the platform in question.

Recognizing this drag as an opportunity for improvement,
this project aims to define a DSL for describing the type signature
of the "function" metaphor for any given source code repository.
This description would thus be machine readable,
though human programmers would remain the target demographic for readability.
This description, by convention, would be contained in a `repo.<ext>` file
at the root of a repository,
in a human-friendly format like YAML or JSON (or perhaps Cue).

In order to fulfill the purpose of reducing drag for engineers working across
different tech stacks, this DSL must be completely independent
of language, platform, or media type stored within the repository.
We already have plenty of tools that will happily take over your entire project,
replacing all of your tools with their own stack and configuration language.
Rather than be just another competitor in that crowded space,
this tool would instead aim to provide enough utility
and improvement in developer ergonomics across any type of project
that the `repo.yaml` or `repo.cue` file would be just as expected or useful
to a repository as a README file (if not more so).

## Why Would This Be Useful?

Given how foreign these objectives seem to be to the discipline of software development,
What potential exists in a world where this concept has been developed and adopted?
(In the absence of existing "killer apps" built on top of this technology
after it already exists, I want to make the case that this would be worth pursuing.)

### Polyglot Programmers

This is my personal motivation, as someone who works across a large number
of small projects in different technologies as opposed to
a smaller number of big projects in a fewer number of technologies.
The one way I can most increase my capacity in such a situation
is to focus my efforts on CI/CD such that I can implement automated testing
and deployment on every single one of my projects,
and not have to worry about breaking things or messing up a deployment
when I context switch between completely unrelated projects to make changes.
However, CI/CD workflows add a lot of complexity to a project,
which means there's still significant overhead from context switching.
A declarative, structured description of the repo's architecture
would aid tremendously in the creation of CI/CD workflows,
and also vastly improve the time to reorient oneself when switching to a new repo.

### Repo Auditing

A common language for describing what assets a repo provides,
what technologies it depends on, and what testing procedures it can use
would enable an organization to audit an entire enterprise of source code repositories,
regardless of which platforms or technologies are in use in each one.
This kind of audit could potentially differentiate between project source code
and build script source code, whether a repo is set up for continuous deployment
or just continuous integration, and what kinds of testing libraries are in use.
Tools for doing this today seem to use implicit heuristics that
scan the contents of repositories for file types that the tool understands,
and infers what they mean in the larger scope of the repo,
instead of having a way for the repo to just claim to the tool explicitly
what it is doing.

### Technology-agnostic, Composable Project Scaffolding

What's the difference between writing a Node.js app as a JavaScript file in ES5,
and writing that same app, but producing a Docker image instead of a server.js file?
What's the difference between the ES5 source files that can be run directly,
and TypeScript files which compile to ES5, or which instead compile to the
latest version of ECMAScript that can be run by Node 14?
What if you have a monorepo that mixes a couple of different languages,
each with their own build tooling?
I have a _hunch_ that the problem of semantically being able to describe
the structure and organization of a repo is isomorphic to the problem of
being able to dynamically generate project scaffolding by composing individual
technology-specific chunks of scaffold.
Yeoman already exists, but I suspect its reach is limited by the fact that
it is exclusive to web technologies, and at the end of the day is just a
glorified templating system.
