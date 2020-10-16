# describe-repo-schema

Declarative repository architecture.

This project aims to create a structured definition format
for everything that usually appears in the README.md file of a git repo.

This definition would be stored in a `repo.yaml` file at the root of every repo.

In turn, this file provides an at-a-glance overview of what the repo provides
and what a developer needs to have installed (if anything) to produce
or retrieve those artifacts.
If a repo "provides" an artifact, it means that objects inside the repo
can be executed, compiled, or referenced directly to produce
some kind of artifact that could be consumed by or executed on
a different system.

The existence of a `repo.yaml` file in the repo root directory indicates
that the repo provides a `repo.yaml` file.
All other artifacts provided by the repo should be described in this file.