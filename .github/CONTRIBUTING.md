# Contributing to epair

## Filing an issue

For bug fixes we recommend you file an issue and provide relevant information, and example code that will reproduce the problem. For suggesting new ideas to increase functionality or other changes, file an issue with as much detail as possible.

## How to make changes

Process for large contributions:

* First, file an issue for maintainers to review and approve. This will allow the maintainers to decide if the changes will be beneficial to the package before the contributer spends time on any contributions. 

* Create a pull request against the master branch by forking the repository, and create a new branch with a name relevant to the changes being made in the forked project.

* All documentation should be written using roxygen2.

* If appropriate, it is recommended that an attempt is made to include relevant tests for new contributions using testthat.

* Run Build->Check Package in the RStudio IDE, or `devtools::check()`, to make sure any contributions did not add any messages, warnings, or errors.

* After going through these steps, submit the pull request, and we will evaluate whether any code should be modified or if it can be merged. We aim to provide feedback in the case that we decide not to merge the pull request. 


Process for typos, documentation, or bug fixes:

Create a Pull Request against the master branch by forking the repository, and create a new branch with a name relevant to the changes being made in the forked project. You can then submit the pull request, making sure both the RMD Check and test coverage checks pass.

## Code of Conduct

Please note that the pkgdown project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
project you agree to abide by its terms.

